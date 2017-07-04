//
//  TumblrService.swift
//  monokit
//
//  Created by mono on 2017/02/12.
//  Copyright © 2017 mono. All rights reserved.
//

import Foundation
import RxSwift
import APIKit
import SwiftyUserDefaults
import Lib

public enum TumblrError: Error {
    case
    post(code: String)
}

public class TumblrService {

    private init() {}
    public static let shared = TumblrService()

//    public var user: String? { return Lib.Defaults[.user] }
//    public var apiToken: String? { return keychain[Keychain.apiTokenKey] }
//    var authToken: String? {
//        guard let user = user, let apiToken = apiToken else {
//            return nil
//        }
//        return "\(user):\(apiToken)"
//    }
    public func post(url: URL) -> Observable<PostCreatedResponse> {
        AuthInfo.shared.auth()
        return Session.shared.rx
            .response(PostRequests.PostLink(url: url))
    }
}
