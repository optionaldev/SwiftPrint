//
// The SwiftPrint project.
// Created by optionaldev on 27/02/2021.
// Copyright © 2021 optionaldev. All rights reserved.
// 

import Foundation
@testable import SwiftPrint

final class TestHelper {
    final class MockObject {
        init() {}
    }
    
    static func resetToDefaultState() {
        SwiftPrint.Setup.isEnabled = true
        SwiftPrint.Setup.logLevel = .all
    }
    
    static func generateOutput(message: Any?,
                               object: AnyObject? = nil,
                               logType: SwiftPrint.LogType) -> String? {
        return SwiftPrint.generateOutput(message: message,
                                         object: object,
                                         logType: logType,
                                         filePath: "Very/Long/Path/to/the-destionation/_AppDelegate.swift",
                                         lineOfCode: 0)
    }
    
    static func generateRandomOutput(forLogType logType: SwiftPrint.LogType) -> String? {
        return generateOutput(message: Date(), object: self, logType: logType)
    }
    
    static func generateRandomOutput() -> String? {
        return generateRandomOutput(forLogType: .info)
    }
    
    static func getTestArray() -> [MockObject] {
        var result: [MockObject] = []
        for _ in 0 ..< 30 {
            result.append(MockObject())
        }
        return result
    }
}

