//
//  LoggerTests.swift
//  monokit
//
//  Created by mono on 2017/02/11.
//  Copyright © 2017 mono. All rights reserved.
//

import XCTest
import os.log
@testable import Lib

class LibTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testBuildOutput() {
        XCTAssertEqual(Logger.buildOutput("(　´･‿･｀)", logType: .debug, functionName: "function_name", fileName: "foo/file_name", lineNumber: 11),
                       "[🔹(debug)] [main] [file_name:11] function_name > (　´･‿･｀)")
    }

    func testDebug() {
        logger.debug("出力テストは難しいのでとりあえずエラー起きなかったらOK(　´･‿･｀)")
    }
}
