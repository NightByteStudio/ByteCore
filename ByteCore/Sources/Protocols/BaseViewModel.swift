//
//  BaseViewModel.swift
//  ByteCore
//
//  Created by Nico Christian on 13/09/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import Foundation

public protocol BaseViewModel {
    func getAllStates() -> [AnyState]
}
