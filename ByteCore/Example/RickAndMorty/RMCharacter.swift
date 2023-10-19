//
//  RMCharacter.swift
//  ByteCore
//
//  Created by Nico on 19/09/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import Foundation

internal struct RMCharacter: Codable {
    internal var id: Int
    internal var name: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
