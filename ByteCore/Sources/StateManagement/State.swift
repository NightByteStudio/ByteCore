//
//  State.swift
//  ByteCore
//
//  Created by Nico Christian on 13/09/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

public enum State<T> {
    case initiate
    case loading
    case success(T)
    case empty
    case failed(Error)
}

public extension State {
    var data: T? {
        switch self {
            case let .success(data):
                return data
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
    
    var isSuccess: Bool {
        switch self {
            case .success:
                return true
            default:
                return false
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
