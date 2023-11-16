//
//  LocalError.swift
//  ByteCore
//
//  Created by Gilbert Nicholas on 12/10/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

public enum LocalError: Error {
    case saveError
    case deleteError
    case dataNotExists
    case realmError
    case dataNotFound
    case unknown
}
