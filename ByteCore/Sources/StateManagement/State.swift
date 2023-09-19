//
//  State.swift
//  ByteCore
//
//  Created by Nico Christian on 13/09/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import Foundation

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
      case .success(let data):
        return data
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
  
  var isSuccess: Bool {
    switch self {
      case .success:
        return true
      default:
        return false
    }
  }
  
  var isError: Error? {
    switch self {
      case .failed(let error):
        return error
      default:
        return nil
    }
  }
}
