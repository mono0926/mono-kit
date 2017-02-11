//
//  Request.extension.swift
//  monokit
//
//  Created by mono on 2017/02/11.
//  Copyright © 2017 mono. All rights reserved.
//

import Foundation
import APIKit

protocol ApiRequest: Request {}

extension ApiRequest {
    var baseURL: URL { return URL(string: "https://api.pinboard.in/v1/")! }
}
