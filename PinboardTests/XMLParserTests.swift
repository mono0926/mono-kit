//
//  XMLParserTests.swift
//  monokit
//
//  Created by mono on 2017/02/11.
//  Copyright © 2017 mono. All rights reserved.
//

import XCTest
import Lib
import RxSwift
import APIKit
import SWXMLHash
@testable import Pinboard

class XMLParserTests: XCTestCase {
    private let target = Pinboard.XMLParser()

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testParse() {
        let data = "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\n<result>(　´･‿･｀)</result>\n".data(using: .utf8)!
        let result = try? target.parse(data: data)
        XCTAssertNotNil(result)
        let xml = result as? XMLIndexer
        XCTAssertNotNil(xml)
        XCTAssertEqual(xml!["result"].element!.text, "(　´･‿･｀)")
    }

}
