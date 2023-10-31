//
//  SimpleCancellable.swift
//  ByteCoreTests
//
//  Created by Nico Christian on 19/10/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import Moya

internal final class SimpleCancellable: Cancellable {
    var isCancelled: Bool = false
    
    func cancel() {}
}
