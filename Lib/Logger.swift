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
    private static let log = OSLog(subsystem: "com.mono0926.monokit", category: "default")

    fileprivate init() {}

    public func info(_ message: @autoclosure () ->  Any, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line) {
        doLog(message, logType: .info, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    public func debug(_ message: @autoclosure () ->  Any, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line) {
        doLog(message, logType: .debug, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    public func error(_ message: @autoclosure () ->  Any, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line) {
        doLog(message, logType: .error, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    public func fault(_ message: @autoclosure () ->  Any, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line) {
        doLog(message, logType: .fault, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    public func `default`(_ message: @autoclosure () ->  Any, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line) {
        doLog(message, logType: .default, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    private func doLog(_ message: @autoclosure () ->  Any, logType: OSLogType, functionName: StaticString, fileName: StaticString, lineNumber: Int) {
        let logger = type(of: self)
        let output = logger.buildOutput(message, logType: logType, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        os_log("%@", log: logger.log, type: logType, output)
    }

    static func buildOutput(_ message: @autoclosure () ->  Any,
                             logType: OSLogType,
                             functionName: StaticString,
                             fileName: StaticString,
                             lineNumber: Int) -> String {
        return "[\(logType)] [\(threadName)] [\((String(describing: fileName) as NSString).lastPathComponent):\(lineNumber)] \(functionName) > \(message())"
    }

    private static var threadName: String {
        if Thread.isMainThread {
            return "main"
        }
        else {
            if let threadName = Thread.current.name, !threadName.isEmpty {
                return threadName
            }
            else if let queueName = DispatchQueue.currentQueueLabel, !queueName.isEmpty {
                return queueName
            }
            else {
                return String(format: "[%p] ", Thread.current)
            }
        }
    }
}

extension DispatchQueue {
    public static var currentQueueLabel: String? {
        return String(validatingUTF8: __dispatch_queue_get_label(nil))
    }
}

public let logger = Logger()
