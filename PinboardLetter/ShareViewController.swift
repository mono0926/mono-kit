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
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        process()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        process()
    }

    private func process() {
        let type = String(describing: kUTTypeURL)
        guard let item = (extensionContext?.inputItems.flatMap { $0 as? NSExtensionItem })?.first,
        let provider = (item.attachments?.flatMap { $0 as? NSItemProvider })?.first,
        provider.hasItemConformingToTypeIdentifier(type) else {
            return
        }
        provider.loadItem(forTypeIdentifier: type, options: nil) { result, error in
            logger.error(error)
            guard let url = result as? URL else {
                logger.error("result(\(result) is not URL")
                return
            }
            self.postToPinboard(url: url)
        }
    }

    private func postToPinboard(url: URL) {
        Lib.Progress.show()
        PinboardService.shared.post(url: url, tag: "letter")
            .subscribe { event in
                switch event {
                case .error(let error):
                    Lib.Progress.error(error)
                case .completed:
                    break
                case .next(let code):
                    logger.debug("code: \(code)")
                    Lib.Progress.success()
                }
            }
            .addDisposableTo(disposeBag)
    }

//    override func isContentValid() -> Bool {
//        // Do validation of contentText and/or NSExtensionContext attachments here
//        return true
//    }
//
//    override func didSelectPost() {
//        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
//    
//        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
//        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
//    }
//
//    override func configurationItems() -> [Any]! {
//        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
//        return []
//    }

}
