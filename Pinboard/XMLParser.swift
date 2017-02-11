//
//  XMLParser.swift
//  monokit
//
//  Created by mono on 2017/02/11.
//  Copyright © 2017 mono. All rights reserved.
//

import Foundation
import APIKit
import SWXMLHash
import Lib

struct XMLParser: DataParser {
    var contentType: String? { return "application/xml" }
    func parse(data: Data) throws -> Any {
        let xml = SWXMLHash.config { _ in }.parse(data)
        return xml
    }
}
