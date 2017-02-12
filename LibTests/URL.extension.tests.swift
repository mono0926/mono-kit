//
//  URL.extension.swift
//  monokit
//
//  Created by mono on 2017/02/12.
//  Copyright © 2017 mono. All rights reserved.
//
import XCTest
import os.log
@testable import Lib

class URLExtensionTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetHTMLTitle_success() {
        XCTAssertEqual(URL(string: "https://mono0926.com")!.getHTMLTitle(), "mono-log")
    }
    func testGetHTMLTitle_not_found() {
        XCTAssertEqual(URL(string: "https://mono0926_.com")!.getHTMLTitle(), "mono0926_.com")
    }
}
