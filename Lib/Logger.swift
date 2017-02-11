//
//  Log.swift
//  monokit
//
//  Created by mono on 2017/02/11.
//  Copyright © 2017 mono. All rights reserved.
//

import Foundation
import os.log

extension OSLogType: CustomStringConvertible {
    public var description: String {
        switch self {
        case OSLogType.info:
            return "ℹ️(info)"
        case OSLogType.debug:
            return "🔹(debug)"
        case OSLogType.error:
            return "‼️(error)"
        case OSLogType.fault:
            return "💣(fault)"
        default:
            return "DEFAULT"
        }
    }
}


/// @see https://developer.apple.com/reference/os/logging#1682426
public struct Logger {

    fileprivate init() {}

    public func info(_ message: @autoclosure () ->  String, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line) {
        doLog(message, logType: .info, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    public func debug(_ message: @autoclosure () ->  String, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line) {
        doLog(message, logType: .debug, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    public func error(_ message: @autoclosure () ->  String, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line) {
        doLog(message, logType: .error, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    public func fault(_ message: @autoclosure () ->  String, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line) {
        doLog(message, logType: .fault, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    public func `default`(_ message: @autoclosure () ->  String, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line) {
        doLog(message, logType: .default, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    private func doLog(_ message: @autoclosure () ->  String, logType: OSLogType, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line) {
        let log = OSLog(subsystem: "com.mono0926.monokit", category: "default")
        os_log("[%@] %@",
               log: log,
               type: logType,
               String(describing: logType), message())
    }
}

public let logger = Logger()
