//
//  PostRequests.swift
//  monokit
//
//  Created by mono on 2017/02/12.
//  Copyright © 2017 mono. All rights reserved.
//

import Foundation
import Lib
import APIKit
import Himotoki

struct PostRequests {
    private init() {}

    struct PostLink: ApiRequest {
        private let url: URL

        typealias Response = PostCreatedResponse
        var method: HTTPMethod { return .post }
        var path: String { return "post" }

        var bodyParameters: BodyParameters? {
            return FormURLEncodedBodyParameters.init(formObject:
                ["type": "link",
                    "url": url.absoluteString,
                    "title": url.getHTMLTitle()])
        }

        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> PostCreatedResponse {
            return PostCreatedResponse()
        }

        init(url: URL) {
            self.url = url
        }
    }
}

public struct PostCreatedResponse {
}
