//
//  ShareExtension.swift
//  monokit
//
//  Created by mono on 2017/02/12.
//  Copyright © 2017 mono. All rights reserved.
//

import Foundation
import Lib

public protocol TumblrExtension: ShareExtension {
    func shareToPinboard()
}

public extension TumblrExtension {
    func shareToPinboard() {
        getShareURL(postToTumblr)
    }
    private func postToTumblr(url: URL) {
        Lib.Progress.show()
        TumblrService.shared.post(url: url)
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
                case .next(let response):
                    logger.debug("response: \(response)")
                    self.complete()
                }
            }
            .addDisposableTo(disposeBag)
    }
}
