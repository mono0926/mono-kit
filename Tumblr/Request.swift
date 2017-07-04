//
//  Request.swift
//  monokit
//
//  Created by mono on 2017/02/12.
//  Copyright © 2017 mono. All rights reserved.
//

import Foundation
import APIKit
import OAuthSwift

class AuthInfo {
    fileprivate var blogIdentifier = ""
    fileprivate var consumerKey = ""
    fileprivate var consumerSecret = ""
    fileprivate var token = ""
    fileprivate var tokenSecret = ""

    private init() {}
    static let shared = AuthInfo()

    func update(blogIdentifier: String, consumerKey: String, consumerSecret: String, token: String, tokenSecret: String) {
        self.blogIdentifier = blogIdentifier
        self.consumerKey = consumerKey
        self.consumerSecret = consumerSecret
        self.token = token
        self.tokenSecret = tokenSecret
    }

    func auth() {
        AuthInfo.shared.update(blogIdentifier: "mono0926.tumblr.com",
                               consumerKey: "",
                               consumerSecret: "",
                               token: "",
                               tokenSecret: "")
    }

}

protocol ApiRequest: Request {}

extension ApiRequest {
    var baseURL: URL { return URL(string: "https://api.tumblr.com/v2/blog/\(AuthInfo.shared.blogIdentifier)/")! }
    var headerFields: [String : String] {
//        let oauth = OAuth1Swift(consumerKey: "", consumerSecret: "", requestTokenUrl: "", authorizeUrl: "", accessTokenUrl: "")
//        oauth.client.credential
        let authInfo = AuthInfo.shared
        let credential = OAuthSwiftCredential(consumerKey: authInfo.consumerKey,
                                              consumerSecret: authInfo.consumerSecret)
        credential.oauthToken = authInfo.token
        credential.oauthTokenSecret = authInfo.tokenSecret
        return credential.makeHeaders(URL(string: "\(baseURL)\(path)")!,
                                             method: OAuthSwiftHTTPRequest.Method.init(rawValue: method.rawValue.uppercased())! ,
                                             parameters: (bodyParameters as! FormURLEncodedBodyParameters).form)
    }
}
