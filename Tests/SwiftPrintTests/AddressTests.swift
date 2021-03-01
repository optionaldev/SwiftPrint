//
// The SwiftPrint project.
// Created by optionaldev on 01/03/2021.
// Copyright © 2021 optionaldev. All rights reserved.
// 


import XCTest
@testable import SwiftPrint

final class XAddressTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        TestHelper.resetToDefaultState()
    }
    
    func testAddressCorrectOutput() {
        XCTAssertEqual(SwiftPrint.address(of: TestHelper.MockObject())?.count, 18)
        XCTAssertEqual(SwiftPrint.address(of: TestHelper.MockObject())?.hasPrefix("0x"), true)
    }
    
    func testAddressNonEmpty() {
        XCTAssertNotEqual(SwiftPrint.address(of: TestHelper.MockObject()), "")
    }
    
    func testAddressNil() {
        XCTAssertEqual(SwiftPrint.address(of: nil), nil)
    }
    
    func testAddressManagement() {
        let testObjects = TestHelper.getTestArray()
        var addressContainer: Set<String> = []
        
        // keep the initial retain counts and check at the end of the test
        // to make sure that we're not retaining the objects
        var initialRetainCounts: [CFIndex] = []
        
        // Get initial retain counts
        for index in 0 ..< testObjects.count {
            initialRetainCounts.append(CFGetRetainCount(testObjects[index]))
        }
        
        // Test initial reference count
        for index in 0 ..< testObjects.count {
            XCTAssertEqual(CFGetRetainCount(testObjects[index]), initialRetainCounts[index])
        }
        
        for index in 0 ..< testObjects.count {
            if let address = SwiftPrint.address(of: testObjects[index]) {
                addressContainer.insert(address)
                
                XCTAssertTrue(addressContainer.contains(address))
                XCTAssertEqual(addressContainer.count, index + 1)

                XCTAssertEqual(CFGetRetainCount(testObjects[index]), initialRetainCounts[index])

                // Retest to make sure that same value is fetched
                for _ in 0 ..< 10 {
                    XCTAssertEqual(address, SwiftPrint.address(of: testObjects[index]))
                    XCTAssertEqual(CFGetRetainCount(testObjects[index]), initialRetainCounts[index])
                }
            }
            
            // Retest after 'address' exits the for loop scope
            XCTAssertEqual(CFGetRetainCount(testObjects[index]), initialRetainCounts[index])
        }

        // Retest one final time
        for index in 0 ..< testObjects.count {
            XCTAssertEqual(CFGetRetainCount(testObjects[index]), initialRetainCounts[index])
        }
    }
    
    static var allTests = [
        ("testAddressCorrectOutput", testAddressCorrectOutput),
        ("testAddressNonEmpty", testAddressNonEmpty),
        ("testAddressNil", testAddressNil),
        ("testAddressManagement", testAddressManagement)
    ]
}
