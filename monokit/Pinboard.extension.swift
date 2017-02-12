//
//  Pinboard.extension.swift
//  monokit
//
//  Created by mono on 2017/02/11.
//  Copyright © 2017 mono. All rights reserved.
//

import Foundation
import Pinboard

extension PinboardError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .post(let code):
            return String(format: NSLocalizedString("pinbaord.error_code_format", comment: ""), code)
        case .invalid(let response):
            return String(format: NSLocalizedString("pinbaord.invalid_response_format", comment: ""), String(describing: response))
        }
    }
}
