//
//  PostRequests.swift
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

struct PostRequests {
    private init() {}

    struct Add: AuthenticatedRequest {
        private let url: String
        private let description: String
        private let tags: [String]

        typealias Response = PostAddedResponse
        var method: HTTPMethod { return .post }
        var path: String { return "posts/add" }

        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> PostAddedResponse {
            return PostAddedResponse(xml: object as! XMLIndexer)
        }

        var queryParameters: [String : Any]? {
            return apiParameters.merged([
                "url": url,
                "description": description,
                "tags": tags.joined(separator: ",")
                ])
        }

        var headerFields: [String : String] {
            return ["Content-Type": "application/xml"]
        }

        init(url: String, description: String, tags: [String]) {
            self.url = url
            self.description = description
            self.tags = tags
        }
    }
}

struct PostAddedResponse {
    let code: String
    init(xml: XMLIndexer) {
        code = try! xml["result"].value(ofAttribute: "code")
    }
}
