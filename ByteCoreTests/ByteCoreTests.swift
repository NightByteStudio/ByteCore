//
//  ByteCoreTests.swift
//  ByteCoreTests
//
//  Created by Stefan Adisurya on 07/09/23.
//

import XCTest

@testable import ByteCore

internal final class ByteCoreTests: XCTestCase {
    internal func test_currencyDescription() {
        var number: Int = 2519823123450901
        XCTAssertEqual("Rp2.519.823.123.450.901", number.currencyDescription)
        
        number = 0000001
        XCTAssertEqual("Rp1", number.currencyDescription)
        
        number = 010101010
        XCTAssertEqual("Rp10.101.010", number.currencyDescription)
        
        number = 999999999999999999
        XCTAssertEqual("Rp999.999.999.999.999.999", number.currencyDescription)
    }
}
