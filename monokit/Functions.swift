//
//  Functions.swift
//  monokit
//
//  Created by mono on 2017/02/12.
//  Copyright © 2017 mono. All rights reserved.
//

import Foundation
import Lib
import APIKit

func handle(error: Error) {
    logger.error(error)
    if let error = error as? SessionTaskError {
        switch error {
        case .responseError(let error):
            showProgress(error: error)
            return
        case .connectionError(let error):
            showProgress(error: error)
            return
        case .requestError(let error):
            showProgress(error: error)
            return
        }
    }
    Lib.Progress.error(error)
}

private func showProgress(error: Error) {
    logger.error(error)
    Lib.Progress.error(error)
}
