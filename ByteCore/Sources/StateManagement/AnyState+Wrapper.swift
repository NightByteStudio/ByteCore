//
//  AnyState+Wrapper.swift
//  ByteCore
//
//  Created by Nico Christian on 13/09/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import RxCocoa

/**
 * AnyState is a protocol with a method to bind a BehaviorRelay object to a BCViewController object
 * The purpose of these method is provide a single method for a BCViewController type to subscribe to multiple BehaviorRelay objects
 */
public protocol AnyState {
    func bind(to viewController: BCViewController)
}

/**
 * StateWrapper is the default implementation of AnyState
 * T can be any type of object that the BehaviorRelay and State manages
 */
public struct StateWrapper<T>: AnyState {
  public let state: BehaviorRelay<State<T>>
  
  public init(_ state: BehaviorRelay<State<T>>) {
    self.state = state
  }
  
  public func bind(to viewController: BCViewController) {
    viewController.bindViewModelState(state)
  }
}
