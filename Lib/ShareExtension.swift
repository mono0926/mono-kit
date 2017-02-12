//
//  UIViewController.pinboard.swift
//  monokit
//
//  Created by mono on 2017/02/12.
//  Copyright © 2017 mono. All rights reserved.
//

import UIKit
import Social
import RxSwift
import MobileCoreServices
import RxSwift

public protocol ShareExtension {
    weak var statusLabel: UILabel! { get }
    var disposeBag: DisposeBag { get }

    func getShareURL(_ callback: @escaping (URL) -> ())
    func show(status: String)
    func complete()
}

public extension ShareExtension where Self: UIViewController {
    func getShareURL(_ callback: @escaping (URL) -> ()) {
        guard let context = extensionContext else {
            logger.fault("context is nil")
            return
        }
        let type = String(describing: kUTTypeURL)
        guard let item = (context.inputItems.flatMap { $0 as? NSExtensionItem }).first,
            let provider = (item.attachments?.flatMap { $0 as? NSItemProvider }.filter{ $0.hasItemConformingToTypeIdentifier(type) })?.first
            else {
                self.complete()
                return
        }
        provider.loadItem(forTypeIdentifier: type, options: nil) { result, error in
            logger.error(error)
            guard let url = result as? URL else {
                logger.error("result(\(result) is not URL")
                self.complete()
                return
            }
            callback(url)
        }
    }

    func complete() {
        extensionContext!.completeRequest(returningItems: nil, completionHandler: nil)
    }

    func show(status: String) {
        statusLabel.text = status
    }
}
