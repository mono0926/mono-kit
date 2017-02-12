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
        type(of: self).getUrl(context: context) { url in
            guard let url = url else {
                self.complete()
                return
            }
            callback(url)
        }
    }

    // TODO: RxSwift対応すると楽そう
    private static func getUrl(context: NSExtensionContext, callback: @escaping (URL?) -> ()) {
        let urlType = String(describing: kUTTypeURL)
        let textType = String(describing: kUTTypePlainText)
        let providers = context.inputItems
            .flatMap { $0 as? NSExtensionItem }
            .flatMap { $0.attachments?.flatMap { $0 as? NSItemProvider }.flatMap { p -> ItemProviderPair? in
                if p.hasItemConformingToTypeIdentifier(urlType) {
                    return (provider: p, type: urlType)
                } else if p.hasItemConformingToTypeIdentifier(textType) {
                    return (provider: p, type: textType)
                } else {
                    return nil
                }
                }
            }
            .flatMap { $0 }

        loadRecursively(providers: providers, callback: callback)
    }

    typealias ItemProviderPair = (provider: NSItemProvider, type: String)

    private static func loadRecursively(providers: [ItemProviderPair], callback: @escaping (URL?) -> ()) {
        var providers = providers
        guard let p = providers.popLast() else {
            callback(nil)
            return
        }
        p.provider.loadItem(forTypeIdentifier: p.type, options: nil) { result, error in
            logger.error(error)
            if p.type == String(describing: kUTTypeURL), let url = result as? URL {
                callback(url)
                return
            }
            if p.type == String(describing: kUTTypePlainText), let result = result as? String, let url = URL(string: result) {
                callback(url)
                return
            }
            logger.error("result(\(result) is not URL")
            loadRecursively(providers: providers, callback: callback)
        }
    }

//    private static func getUrl(context: NSExtensionContext, type: CFString, _ callback: @escaping (URL?) -> ()) {
//        let typeS = String(describing: type)
//        let provider = context.inputItems
//            .flatMap { $0 as? NSExtensionItem }
//            .flatMap { $0.attachments?.flatMap { $0 as? NSItemProvider }.filter{ print($0); return $0.hasItemConformingToTypeIdentifier(typeS) }.first }
//            .first
//        guard let p = provider else {
//            callback(nil)
//            return
//        }
//        p.load
//        p.loadItem(forTypeIdentifier: typeS, options: nil) { result, error in
//            logger.error(error)
//            guard let url = result as? URL else {
//                logger.error("result(\(result) is not URL")
//                callback(nil)
//                return
//            }
//            callback(url)
//        }
//    }

    func complete() {
        extensionContext!.completeRequest(returningItems: nil, completionHandler: nil)
    }

    func show(status: String) {
        statusLabel.text = status
    }
}
