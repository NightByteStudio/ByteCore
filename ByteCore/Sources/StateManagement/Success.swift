//
//  Success.swift
//  ByteCore
//
//  Created by Nico Christian on 05/12/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

/**
 * SuccessState: An enum case that handles a view model success state that can both have data or no data at all
 */
public enum SuccessState<T> {
    case noData
    case withData(T)
    
    public var data: T? {
        switch self {
            case .noData:
                return nil
            case let .withData(data):
                return data
        }
    }
}
