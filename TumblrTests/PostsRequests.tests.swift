//
//  PostsRequests.tests.swift
//  monokit
//
//  Created by mono on 2017/02/12.
//  Copyright © 2017 mono. All rights reserved.
//
import XCTest
import Lib
import RxSwift
import APIKit
import SwiftyUserDefaults
@testable import Tumblr

class PostRequestsTests: XCTestCase {
    private let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testPostLink() {
        let expectation = self.expectation(description: #function)

        AuthInfo.shared.test()

        let request = PostRequests.PostLink(url: URL(string: "https://mono0926.com")!)
        Session.shared.rx.response(request)
            .subscribe { [unowned self] event in
                switch event {
                case .error(let error):
                    XCTFail(String(describing: error))
                case .next(let element):
                    logger.debug(element)
                case .completed:
                    expectation.fulfill()
                }
            }.addDisposableTo(disposeBag)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
