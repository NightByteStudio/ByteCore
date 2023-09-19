//
//  AnyState+Wrapper.swift
//  ByteCore
//
//  Created by Nico Christian on 13/09/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import Foundation
import RxCocoa

public protocol AnyState {
    func bind(to viewController: BCViewController)
}

public struct StateWrapper<T>: AnyState {
  public let state: BehaviorRelay<State<T>>
  
  public init(_ state: BehaviorRelay<State<T>>) {
    self.state = state
  }
  
  public func bind(to viewController: BCViewController) {
    viewController.bindViewModelState(state)
  }
}
