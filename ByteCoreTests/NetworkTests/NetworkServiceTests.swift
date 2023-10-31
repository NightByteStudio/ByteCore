//
//  NetworkServiceTests.swift
//  ByteCoreTests
//
//  Created by Nico Christian on 19/10/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import XCTest
import Moya
import Nimble
import RxBlocking
@testable import ByteCore

internal final class NetworkServiceTests: XCTestCase {
    private var networkService: NetworkService<MockAPI>!
    private var mockProvider: MockMoyaProvider<MockAPI>!

    override func setUp() {
        super.setUp()
        mockProvider = MockMoyaProvider()
        networkService = NetworkService(provider: mockProvider)
    }

    override func tearDown() {
        networkService = nil
        mockProvider = nil
        super.tearDown()
    }
    
    func testSuccessfulResponse() {
        let expectedData = """
        {
            "status": "success",
            "data": "Success Response"
        }
        """.data(using: .utf8)!
        let response = Response(statusCode: 200, data: expectedData)
        mockProvider.testResult = .success(response)

        expect {
            try self.networkService.fetch(MockAPI.mockEndpoint, responseObject: MockModel.self).toBlocking().single()
        }.notTo(beNil())
    }

    func testJsonMappingError() {
        let invalidData = "Invalid JSON".data(using: .utf8)!
        let response = Response(statusCode: 200, data: invalidData)
        mockProvider.testResult = .success(response)

        expect {
            try self.networkService.fetch(MockAPI.mockEndpoint, responseObject: MockModel.self).toBlocking().single()
        }.to(throwError { error in
            expect(error).to(matchError(APIError.invalidJSON))
        })
    }
    
    func testNetworkUnavailableError() {
        let underlyingError = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        mockProvider.testResult = .failure(.underlying(underlyingError, nil))
        
        expect {
            try self.networkService.fetch(MockAPI.mockEndpoint, responseObject: MockModel.self).toBlocking().single()
        }.to(throwError { error in
            expect(error).to(matchError(APIError.networkUnavailable))
        })
    }
    
    func testServerError() {
        let response = Response(statusCode: 500, data: Data())
        mockProvider.testResult = .success(response)
        
        expect {
            try self.networkService.fetch(MockAPI.mockEndpoint, responseObject: MockModel.self).toBlocking().single()
        }.to(throwError { error in
            expect(error).to(matchError(APIError.serverError(.init(responseCode: 500))))
        })
    }
    
    func testGeneralError() {
        mockProvider.testResult = .failure(.requestMapping(""))
        
        expect {
            try self.networkService.fetch(MockAPI.mockEndpoint, responseObject: MockModel.self).toBlocking().single()
        }.to(throwError { error in
            expect(error).to(matchError(APIError.unknown))
        })
    }
    
    func testUnhandledMoyaError() {
        mockProvider.testResult = .failure(.requestMapping("test"))

        expect {
            try self.networkService.fetch(MockAPI.mockEndpoint, responseObject: MockModel.self).toBlocking().single()
        }.to(throwError { error in
            expect(error).to(matchError(APIError.unknown))
        })
    }
}
