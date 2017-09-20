//
//  URL.extension.swift
//  monokit
//
//  Created by mono on 2017/02/12.
//  Copyright © 2017 mono. All rights reserved.
//

import Foundation

extension URL {
    public func getHTMLTitle() -> String {
        do {
            let source = try String(contentsOf: self)
            guard let start = source.range(of: "<title>"), let end = source.range(of: "</title>") else {
                logger.error("no title tag, return host(\(host ?? ""))")
                return host ?? absoluteString
            }
            return String(source[start.upperBound..<end.lowerBound])
        } catch let e {
            logger.fault(e)
            return host ?? absoluteString
        }
    }
}
