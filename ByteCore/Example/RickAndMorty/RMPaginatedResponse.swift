//
//  RMPaginatedResponse.swift
//  ByteCore
//
//  Created by Nico on 19/09/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

/**
 * RMPaginatedResponse is a generic struct with constraint type of Codable, made to wrap result data from the Rick and Morty API
 * All the returns from the API are in pagination format
 * This type will be used in RMRepository in the NetworkService call
 * Example usage: RMPaginatedResponse<RMCharacter>.self
 */
internal struct RMPaginatedResponse<T: Codable>: Codable {
    internal var results: [T]?
    
    internal enum CodingKeys: String, CodingKey {
        case results
    }
}
