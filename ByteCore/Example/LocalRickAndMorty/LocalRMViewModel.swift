//
//  LocalRMViewModel.swift
//  ByteCore
//
//  Created by Gilbert Nicholas on 12/10/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift

internal final class LocalRMViewModel {
    private let repository: LocalRMRepository
    private let disposeBag = DisposeBag()
    
    let initRealmState: BehaviorRelay<State<Void>> = .init(value: .initiate)
    let saveDataLocalState: BehaviorRelay<State<Void>> = .init(value: .initiate)
    let getDataLocalState: BehaviorRelay<State<[LocalRMCharacter]>> = .init(value: .initiate)
    let deleteDataLocalState: BehaviorRelay<State<Void>> = .init(value: .initiate)

    internal init() {
        self.repository = .init()
        initRealm()
    }
    
    private func initRealm() {
        initRealmState.accept(.loading)
        repository.initRealm().subscribe { [weak self] completable in
            switch completable {
            case .completed:
                self?.initRealmState.accept(.success(()))
            case .error(let error):
                self?.initRealmState.accept(.failed(error))
            }
        }
        .disposed(by: disposeBag)
    }

    internal func saveData(id: Int, name: String) {
        saveDataLocalState.accept(.loading)
        
        let objectLocal = LocalRMCharacter()
        objectLocal.id = id
        objectLocal.name = name
        
        repository.saveData(object: objectLocal).subscribe { [weak self] completable in
            switch completable {
            case .completed:
                self?.saveDataLocalState.accept(.success(()))
                self?.getData()
            case .error(let error):
                self?.saveDataLocalState.accept(.failed(error))
            }
        }
        .disposed(by: disposeBag)
    }

    internal func getData() {
        getDataLocalState.accept(.loading)
        
        repository.getData().subscribe { [weak self] characters in
            if characters.isEmpty {
                self?.getDataLocalState.accept(.empty)
            } else {
                self?.getDataLocalState.accept(.success(characters))
            }
        } onFailure: { [weak self] error in
            self?.getDataLocalState.accept(.failed(error))
        }
        .disposed(by: disposeBag)
    }

    internal func deleteData() {
        deleteDataLocalState.accept(.loading)
        
        repository.deleteData().subscribe { [weak self] completable in
            switch completable {
            case .completed:
                self?.deleteDataLocalState.accept(.success(()))
            case .error(let error):
                self?.deleteDataLocalState.accept(.failed(error))
            }
        }
        .disposed(by: disposeBag)
    }
}
