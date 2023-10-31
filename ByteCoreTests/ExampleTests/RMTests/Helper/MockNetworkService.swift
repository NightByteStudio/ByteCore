//
//  MockNetworkService.swift
//  ByteCoreTests
//
//  Created by Nico Christian on 31/10/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import Moya
import RxSwift
@testable import ByteCore

internal final class MockRMNetworkService<T: TargetType>: NetworkService<T> {
    
    internal var character: RMCharacter?
    internal var characters: RMPaginatedResponse<RMCharacter>?
    internal var error: APIError?
    
    override func fetch<U>(_ api: T, responseObject: U.Type) -> Single<U> where U : Decodable, U : Encodable {
        return Single.create { [weak self] single in
            
            if let rmAPI = api as? RMAPI {
                switch rmAPI {
                    case .getCharacters:
                        if let characters = self?.characters as? U {
                            single(.success(characters))
                        } else {
                            single(.failure(NSError(domain: "TestError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to cast data to type \(T.self)"])))
                        }
                    case .getCharacter:
                        if let character = self?.character as? U {
                            single(.success(character))
                        } else {
                            single(.failure(NSError(domain: "TestError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to cast data to type \(T.self)"])))
                        }
                }
            } else {
                single(.failure(NSError(domain: "TestError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to cast API to type RMAPI"])))
            }
            
            return Disposables.create()
        }
    }
}
