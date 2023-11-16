//
//  LocalRMCharacter.swift
//  ByteCore
//
//  Created by Gilbert Nicholas on 12/10/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import RealmSwift

internal class LocalRMCharacter: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var name: String = ""
}
