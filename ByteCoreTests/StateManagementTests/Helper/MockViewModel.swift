//
//  MockViewModel.swift
//  ByteCoreTests
//
//  Created by Nico Christian on 19/10/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import ByteCore
import RxCocoa

internal final class MockViewModel: BaseViewModel {
    let mockEndpointState: BehaviorRelay<State<MockModel>> = .init(value: .initiate)
    
    func getAllStates() -> [AnyState] {
        return [
            StateWrapper(mockEndpointState)
        ]
    }
}
