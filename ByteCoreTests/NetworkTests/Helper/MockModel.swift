//
//  MockModel.swift
//  ByteCoreTests
//
//  Created by Nico Christian on 19/10/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

internal struct MockModel: Codable {
    var status: String
    var data: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
    }
}
