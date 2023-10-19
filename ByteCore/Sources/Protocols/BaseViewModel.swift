//
//  BaseViewModel.swift
//  ByteCore
//
//  Created by Nico Christian on 13/09/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

/**
 * BaseViewModel is a default protocol for view model implementation
 * getAllStates() -> [AnyState] is a method that will be implemented by the view model, to return all the states that the view controller should subscribe
 */
public protocol BaseViewModel {
    func getAllStates() -> [AnyState]
}
