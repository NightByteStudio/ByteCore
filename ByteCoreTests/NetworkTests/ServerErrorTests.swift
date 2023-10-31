//
//  ServerErrorTests.swift
//  ByteCoreTests
//
//  Created by Nico Christian on 19/10/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import XCTest
@testable import ByteCore

internal final class ServerErrorTests: XCTestCase {
    internal func testServerError() {
        let serverError: ServerError = .init(responseCode: 404, message: "The requested resources not found")
        
        XCTAssert(serverError.responseCode == 404)
        XCTAssert(serverError.message == "The requested resources not found")
    }
}
