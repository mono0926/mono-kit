//
//  ShareViewController.swift
//  PinboardLetter
//
//  Created by mono on 2017/02/12.
//  Copyright © 2017 mono. All rights reserved.
//

import UIKit
import Social
import Lib
import Pinboard
import RxSwift
import MobileCoreServices

class ShareViewController: UIViewController {
    @IBOutlet private weak var statusLabel: UILabel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        process()
    }

    private func process() {
        let type = String(describing: kUTTypeURL)
        guard let item = (extensionContext?.inputItems.flatMap { $0 as? NSExtensionItem })?.first,
            let provider = (item.attachments?.flatMap { $0 as? NSItemProvider }.filter{ $0.hasItemConformingToTypeIdentifier(type) })?.first
             else {
                self.close()
                return
        }
        provider.loadItem(forTypeIdentifier: type, options: nil) { result, error in
            logger.error(error)
            guard let url = result as? URL else {
                logger.error("result(\(result) is not URL")
                self.close()
                return
            }
            self.postToPinboard(url: url)
        }
    }

    private func postToPinboard(url: URL) {
        Lib.Progress.show()
        PinboardService.shared.post(url: url, tags: ["letter🐦"])
            .subscribe { event in
                switch event {
                case .error(let error):
                    let status = Lib.Progress.error(error)
                    self.show(status: status)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        self.close()
                    }
                case .completed:
                    break
                case .next(let code):
                    logger.debug("code: \(code)")
                    self.close()
                }
            }
            .addDisposableTo(disposeBag)
    }

    private func close() {
        extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
    }

    private func show(status: String) {
        statusLabel.text = status
    }
}
