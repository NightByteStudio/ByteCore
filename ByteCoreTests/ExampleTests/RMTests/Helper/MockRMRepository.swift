//
//  MockRMRepository.swift
//  ByteCoreTests
//
//  Created by Nico Christian on 31/10/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import RxSwift
@testable import ByteCore

internal final class MockRMRepository: RMRepository {
    
    internal var charactersResponse: RMPaginatedResponse<RMCharacter>?
    internal var character: RMCharacter?
    internal var error: Error?
    
    internal var networkService: NetworkService<RMAPI>
    
    init(networkService: NetworkService<RMAPI> = .init()) {
        self.networkService = networkService
    }
    
    func getCharacters() -> Single<RMPaginatedResponse<RMCharacter>?> {
        return Single.create { single in
            if let error = self.error {
                single(.failure(error))
            } else if let charactersResponse = self.charactersResponse {
                single(.success(charactersResponse))
            } else {
                single(.failure(NSError(domain: "TestError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Found Error and characterResponse to be nil"])))
            }
            
            return Disposables.create()
        }
    }
    
    func getCharacterDetail(id: Int) -> Single<RMCharacter?> {
        return Single.create { single in
            if let error = self.error {
                single(.failure(error))
            } else if self.character == nil {
                single(.success(nil))
            } else if let character = self.character {
                single(.success(character))
            }
            
            return Disposables.create()
        }
    }
}
