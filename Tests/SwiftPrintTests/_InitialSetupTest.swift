//
// The SwiftPrint project.
// Created by optionaldev on 27/02/2021.
// Copyright © 2021 optionaldev. All rights reserved.
// 

import XCTest
@testable import SwiftPrint

final class _InitialSetupTest: XCTestCase {

    func testInitialState() {
        XCTAssertTrue(SwiftPrint.Setup.isEnabled)
        XCTAssertTrue(SwiftPrint.Setup.logLevel == .all)
        XCTAssertTrue(SwiftPrint.canPrint(.info))
        XCTAssertNotNil(TestHelper.generateRandomOutput())
        XCTAssertNotNil(TestHelper.generateOutput(message: Date(), object: nil, logType: .info))
        XCTAssertNil(TestHelper.generateOutput(message: nil, object: nil, logType: .info))
        XCTAssertNil(TestHelper.generateOutput(message: nil, object: self, logType: .info))
    }

    static var allTests = [
        ("testInitialState", testInitialState),
    ]
}
