//
//  State.swift
//  ByteCore
//
//  Created by Nico Christian on 13/09/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

/**
 * State: An enum case that handles the main state of API calls
 * - initiate: a placeholder value for initiating a BehaviorRelay value
 * - loading: loading state
 * - success: a success state that have one parameter SuccessState
 * - empty: empty state that is triggered when the expected data turns out to be empty
 * - failed: a failed state that have one error parameter
 */
public enum State<T> {
    case initiate
    case loading
    case success(SuccessState<T>)
    case empty
    case failed(Error)
}

public extension State {
    var success: SuccessState<T>? {
        switch self {
            case let .success(state):
                return state
            default:
                return nil
        }
    }
    
    var error: Error? {
        switch self {
            case let .failed(error):
                return error
            default:
                return nil
        }
    }
    
    var isLoading: Bool {
        switch self {
            case .loading:
                return true
            default:
                return false
        }
    }
    
    var isEmpty: Bool {
        switch self {
            case .empty:
                return true
            default:
                return false
        }
    }
}
