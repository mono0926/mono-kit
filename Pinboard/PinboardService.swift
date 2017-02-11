//
//  PinboardService.swift
//  monokit
//
//  Created by mono on 2017/02/11.
//  Copyright © 2017 mono. All rights reserved.
//

import Foundation
import RxSwift
import APIKit
import SwiftyUserDefaults
import Lib

public class PinboardService {

    private init() {}
    public static let shared = PinboardService()

    public var user: String? { return Defaults[.user] }
    public var apiToken: String? { return keychain[Keychain.apiTokenKey] }
    var authToken: String? {
        guard let user = user, let apiToken = apiToken else {
            return nil
        }
        return "\(user):\(apiToken)"
    }

    public func authenticate(user: String, password: String) -> Observable<String> {
        Defaults[.user] = user
        return Session.shared.rx
            .response(UserRequests.ApiToken(user: user, password: password))
            .map { $0.result }
            .do(onNext: { apiToken in
                keychain[Keychain.apiTokenKey] = apiToken
            })
    }
    public func post(url: String, tag: String) -> Observable<String> {
        return Session.shared.rx
            .response(PostRequests.Add(url: url, description: "TODO", tags: [tag, "🐶monoKit🐶"]))
            .map { $0.code }
    }
}
