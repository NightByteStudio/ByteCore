//
//  RMPaginatedResponse.swift
//  ByteCore
//
//  Created by Nico on 19/09/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import Foundation

public struct RMPaginatedResponse<T: Codable>: Codable {
    var results: [T]?
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}
