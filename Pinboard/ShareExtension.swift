//
//  ShareExtension.swift
//  monokit
//
//  Created by mono on 2017/02/12.
//  Copyright © 2017 mono. All rights reserved.
//

import Foundation
import Lib

public protocol PinboardExtension: ShareExtension {
    var tags: [PinboardTag] { get }
    func shareToPinboard()
}

public extension PinboardExtension {
    func shareToPinboard() {
        getShareURL(postToPinboard)
    }
    private func postToPinboard(url: URL) {
        Lib.Progress.show()
        PinboardService.shared.post(url: url, tags: tags.map { $0.rawValue })
            .subscribe { event in
                switch event {
                case .error(let error):
                    let status = Lib.Progress.error(error)
                    self.show(status: status)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        self.complete()
                    }
                case .completed:
                    break
                case .next(let code):
                    logger.debug("code: \(code)")
                    self.complete()
                }
            }
            .addDisposableTo(disposeBag)
    }
}
