//
//  Progress.swift
//  monokit
//
//  Created by mono on 2017/02/11.
//  Copyright © 2017 mono. All rights reserved.
//

import Foundation
import SVProgressHUD
import APIKit

public struct Progress {
    private init() {}
    public static func show() {
        SVProgressHUD.show()
    }
    public static func dismiss() {
        SVProgressHUD.dismiss()
    }
    public static func success(status: String = "Succeeded!🐶🎉") {
        SVProgressHUD.showSuccess(withStatus: status)
    }
    public static func error(status: String) {
        logger.error(status)
        SVProgressHUD.showError(withStatus: status)
    }
    public static func error(_ error: Error) {
        self.error(status: error.localizedDescription)
    }
    public static func handle(error: Error) {
        logger.error(error)
        if let error = error as? SessionTaskError {
            switch error {
            case .responseError(let error):
                self.error(error)
                return
            case .connectionError(let error):
                self.error(error)
                return
            case .requestError(let error):
                self.error(error)
                return
            }
        }
        Lib.Progress.error(error)
    }
}


