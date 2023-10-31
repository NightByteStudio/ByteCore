//
//  StateManagementTests.swift
//  ByteCoreTests
//
//  Created by Nico Christian on 19/10/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import XCTest
import Nimble
@testable import ByteCore

internal final class StateManagementTests: XCTestCase {
    private var viewModel: MockViewModel!
    private var viewController: MockViewController!
    
    override func setUp() {
        super.setUp()
        viewModel = MockViewModel()
        viewController = MockViewController(viewModel: viewModel)
    }
    
    override func tearDown() {
        viewModel = nil
        viewController = nil
        super.tearDown()
    }
    
    func testBindViewModel_AllStates() {
        viewModel.getAllStates().forEach { $0.bind(to: viewController) }
        
        let successMockModel: MockModel = .init(status: "success", data: "data")
        viewModel.mockEndpointState.accept(.success(successMockModel))
        
        expect(self.viewController.status).to(equal("success"))
    }
    
    func testBindViewModel_Success() {
        viewController.bindViewModelState(viewModel.mockEndpointState)
        
        let successMockModel: MockModel = .init(status: "success", data: "data")
        viewModel.mockEndpointState.accept(.success(successMockModel))
        
        expect(self.viewController.status).to(equal("success"))
    }
    
    func testBindViewModel_StartLoading() {
        viewController.bindViewModelState(viewModel.mockEndpointState)
        
        viewModel.mockEndpointState.accept(.loading)
        
        expect(self.viewController.status).to(equal("loading"))
    }
    
    
    func testBindViewModel_Failed() {
        viewController.bindViewModelState(viewModel.mockEndpointState)
        
        viewModel.mockEndpointState.accept(.failed(APIError.unknown))
        
        expect(self.viewController.status).to(equal("error"))
    }
    
    func testBindViewModel_Empty() {
        viewController.bindViewModelState(viewModel.mockEndpointState)
        
        viewModel.mockEndpointState.accept(.empty)
        
        expect(self.viewController.status).to(equal("empty"))
    }
}
