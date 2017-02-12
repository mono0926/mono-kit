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
    func testGetHTMLTitle_success2() {
        XCTAssertEqual(URL(string: "http://qiita.com/mono0926/items/139014be6c15e32b9696")!.getHTMLTitle(), "SwiftのString(文字列) APIとの付き合い方 - Qiita")
    }
    func testGetHTMLTitle_not_found() {
        XCTAssertEqual(URL(string: "https://mono0926_.com")!.getHTMLTitle(), "mono0926_.com")
    }
}
