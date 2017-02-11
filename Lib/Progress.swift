//
//  Progress.swift
//  monokit
//
//  Created by mono on 2017/02/11.
//  Copyright © 2017 mono. All rights reserved.
//

import Foundation
import SVProgressHUD

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
        SVProgressHUD.showError(withStatus: status)
    }
    public static func error(_ error: Error) {
        SVProgressHUD.showError(withStatus: error.localizedDescription)
    }
}


