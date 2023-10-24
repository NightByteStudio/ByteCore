//
//  LocalStorage.swift
//  ByteCore
//
//  Created by Gilbert Nicholas on 11/10/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import RealmSwift
import RxSwift

open class LocalStorage {
    private var realm: Realm?
    
    internal func initRealm() -> Completable {
        return Completable.create { completable in
            let config = RealmSwift.Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            
            do {
                self.realm = try Realm()
                completable(.completed)
            } catch {
                completable(.error(error))
            }
            
            return Disposables.create()
        }
    }
    
    internal func saveDataLocal<T: Object>(object: T) -> Completable {
        return Completable.create { [weak self] completable in
            if let realm = self?.realm {
                do {
                    try realm.write {
                        realm.add(object)
                    }
                    completable(.completed)
                } catch {
                    completable(.error(LocalError.saveError))
                }
            } else {
                completable(.error(LocalError.realmError))
            }
            return Disposables.create()
        }
    }
    
    internal func getDataLocal<T: Object>(object: T.Type) -> Single<[T]> {
        return Single.create { [weak self] single in
            if let realm = self?.realm {
                let results = realm.objects(object)
                let dataArray = Array(results)
                
                if dataArray.isEmpty {
                    single(.failure(LocalError.dataNotExists))
                } else {
                    single(.success(dataArray))
                }
            } else {
                single(.failure(LocalError.realmError))
            }
            return Disposables.create()
        }
    }
    
    internal func deleteDataLocal() -> Completable {
        return Completable.create { [weak self] completable in
            if let realm = self?.realm {
                do {
                    try realm.write {
                        realm.deleteAll()
                    }
                    completable(.completed)
                } catch {
                    completable(.error(LocalError.deleteError))
                }
            } else {
                completable(.error(LocalError.realmError))
            }
            return Disposables.create()
        }
    }
}
