//
//  LocalRMRepository.swift
//  ByteCore
//
//  Created by Gilbert Nicholas on 12/10/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import RxSwift
import RealmSwift

internal class LocalRMRepository {
    private let localStorage: LocalStorage

    internal init() {
        self.localStorage = .init()
    }
    
    internal func initRealm() -> Completable {
        return localStorage.initRealm()
    }

    internal func saveData<T: Object>(object: T) -> Completable {
        return localStorage.saveDataLocal(object: object)
    }

    internal func getData() -> Single<[LocalRMCharacter]> {
        return localStorage.getDataLocal(object: LocalRMCharacter.self)
    }

    internal func deleteData() -> Completable {
        return localStorage.deleteDataLocal()
    }
}
