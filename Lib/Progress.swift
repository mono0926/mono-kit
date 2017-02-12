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
    @discardableResult
    public static func error(_ error: Error) -> String {
        return self.handle(error: error)
    }
    private static func handle(error: Error) -> String {
        logger.error(error)
        if let error = error as? SessionTaskError {
            switch error {
            case .responseError(let error):
                self.error(status: error.localizedDescription)
                return error.localizedDescription
            case .connectionError(let error):
                self.error(status: error.localizedDescription)
                return error.localizedDescription
            case .requestError(let error):
                self.error(status: error.localizedDescription)
                return error.localizedDescription
            }
        }
        Lib.Progress.error(error)
        return error.localizedDescription
    }
}


