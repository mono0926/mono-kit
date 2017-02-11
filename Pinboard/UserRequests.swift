//
//  UserEndpoint.swift
//  monokit
//
//  Created by mono on 2017/02/11.
//  Copyright © 2017 mono. All rights reserved.
//

import Foundation
import Lib
import APIKit
import Himotoki
import SWXMLHash

struct UserRequests {
    private init() {}

    struct ApiToken: ApiRequest {

        private let user: String
        private let password: String

        typealias Response = ApiTokenResponse
        var method: HTTPMethod { return .get }
        var path: String { return "user/api_token" }

        var headerFields: [String : String] {
            let encoded = "\(user):\(password)".data(using: .utf8)!.base64EncodedString()
            return ["Authorization": "Basic \(encoded)"]
        }

        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> ApiTokenResponse {
            return ApiTokenResponse(xml: object as! XMLIndexer)
        }

        init(user: String, password: String) {
            self.user = user
            self.password = password
        }
    }
}

struct ApiTokenResponse {
    let result: String
    init(xml: XMLIndexer) {
        result = xml["result"].element!.text!
    }
}

extension ApiTokenResponse: CustomStringConvertible {
    var description: String { return "" }
}
