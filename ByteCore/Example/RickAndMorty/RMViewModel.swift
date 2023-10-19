//
//  RMViewModel.swift
//  ByteCore
//
//  Created by Nico on 19/09/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import RxCocoa
import RxSwift

internal final class RMViewModel: BaseViewModel {
    let getCharactersState: BehaviorRelay<State<[RMCharacter]>> = .init(value: .initiate)
    let getCharacterDetailState: BehaviorRelay<State<RMCharacter>> = .init(value: .initiate)
    
    private let disposeBag: DisposeBag = .init()
    private let repository: RMRepository = .init()
    
    internal func getCharacters() {
        getCharactersState.accept(.loading)
        
        repository.getCharacters().subscribe { [weak self] response in
            guard let characters = response?.results else {
                self?.getCharactersState.accept(.empty)
                return
            }
            self?.getCharactersState.accept(.success(characters))
        } onFailure: { [weak self] error in
            self?.getCharactersState.accept(.failed(error))
        }
        .disposed(by: disposeBag)
    }

    internal func getCharacterDetail(id: Int) {
        getCharacterDetailState.accept(.loading)
        
        repository.getCharacterDetail(id: id).subscribe { [weak self] character in
            guard let character = character else {
                self?.getCharacterDetailState.accept(.empty)
                return
            }
            self?.getCharacterDetailState.accept(.success(character))
        } onFailure: { [weak self] error in
            self?.getCharacterDetailState.accept(.failed(error))
        }
        .disposed(by: disposeBag)
    }
    
    internal func getAllStates() -> [AnyState] {
        return [
            StateWrapper(getCharactersState),
            StateWrapper(getCharacterDetailState)
        ]
    }
}
