//
//  RMRepository.swift
//  ByteCore
//
//  Created by Nico on 19/09/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import RxSwift

internal protocol RMRepository {
    var networkService: NetworkService<RMAPI> { get }
    
    init(networkService: NetworkService<RMAPI>)
    
    func getCharacters() -> Single<RMPaginatedResponse<RMCharacter>?>
    func getCharacterDetail(id: Int) -> Single<RMCharacter?>
}

internal final class DefaultRMRepository: RMRepository {
    
    internal var networkService: NetworkService<RMAPI>
    
    internal init(networkService: NetworkService<RMAPI> = .init()) {
        self.networkService = networkService
    }
    
    internal func getCharacters() -> Single<RMPaginatedResponse<RMCharacter>?> {
        return networkService.fetch(.getCharacters, responseObject: RMPaginatedResponse<RMCharacter>?.self)
    }
    
    internal func getCharacterDetail(id: Int) -> Single<RMCharacter?> {
        return networkService.fetch(.getCharacter(id), responseObject: RMCharacter?.self)
    }
}
