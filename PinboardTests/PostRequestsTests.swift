//
//  UserRequestsTests.swift
//  monokit
//
//  Created by mono on 2017/02/11.
//  Copyright © 2017 mono. All rights reserved.
//

import XCTest
import Lib
import RxSwift
import APIKit
import SwiftyUserDefaults
@testable import Pinboard

class PostRequestsTests: XCTestCase {
    private let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testApiToken() {
        let expectation = self.expectation(description: #function)

        Lib.Defaults[.user] = TestDataUtil.user
        keychain[Keychain.apiTokenKey] = TestDataUtil.apiToken

        let request = PostRequests.Add(url: URL(string: "https://mono0926.com")!, description: "monokit test", tags: ["test1, test2"])
        Session.shared.rx.response(request)
            .subscribe { [unowned self] event in
                switch event {
                case .error(let error):
                    XCTFail(String(describing: error))
                case .next(let element):
                    logger.debug(element)
                    XCTAssertEqual(element.code, "done")
                case .completed:
                    expectation.fulfill()
                }
        }.addDisposableTo(disposeBag)
        waitForExpectations(timeout: 5, handler: nil)
    }

}
