//
//  RMPaginatedResponse.swift
//  ByteCore
//
//  Created by Nico on 19/09/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import Foundation

internal struct RMPaginatedResponse<T: Codable>: Codable {
    internal var results: [T]?
    
    internal enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}
