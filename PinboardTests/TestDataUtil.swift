//
//  TestDataUtil.swift
//  monokit
//
//  Created by mono on 2017/02/11.
//  Copyright © 2017 mono. All rights reserved.
//

import Foundation

private let testData = NSDictionary(contentsOfFile: Bundle(for: UserRequestsTests.self).path(forResource: "TestData", ofType: "plist")!)!
struct TestDataUtil {
    private init() {}
    static let user = testData["user"] as! String
    static let password = testData["password"] as! String
    static let apiToken = testData["api_token"] as! String
}
