//
//  RMRepository.swift
//  ByteCore
//
//  Created by Nico on 19/09/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import Foundation
import RxSwift

internal final class RMRepository {
    
    private let networkService: NetworkService<RMAPI> = .init()
    
    internal init() { }
    
    internal func getCharacters() -> Single<RMPaginatedResponse<RMCharacter>?> {
        return networkService.fetch(.getCharacters, responseObject: RMPaginatedResponse<RMCharacter>?.self)
    }
    
    internal func getCharacterDetail(id: Int) -> Single<RMCharacter?> {
        return networkService.fetch(.getCharacter(id), responseObject: RMCharacter?.self)
    }
}
