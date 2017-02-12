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
        private let url: URL
        private let description: String
        private let tags: [String]
        private let toread: Bool

        typealias Response = PostAddedResponse
        var method: HTTPMethod { return .post }
        var path: String { return "posts/add" }

        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> PostAddedResponse {
            return try PostAddedResponse(xml: object as! XMLIndexer)
        }

        var queryParameters: [String : Any]? {
            return apiParameters.merged([
                "url": url.absoluteString,
                "description": description,
                "tags": tags.joined(separator: ","),
                "toread": toread ? "yes" : "no"
                ])
        }

        var headerFields: [String : String] {
            return ["Content-Type": "application/xml"]
        }

        init(url: URL, description: String, tags: [String], toread: Bool = true) {
            self.url = url
            self.description = description
            self.tags = tags
            self.toread = toread
        }
    }
}

struct PostAddedResponse {
    let code: String
    init(xml: XMLIndexer) throws {
        code = try xml["result"].value(ofAttribute: "code")
    }
}
