//
//  NetworkService.swift
//  ByteCore
//
//  Created by Nico Christian on 13/09/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import Foundation
import Moya
import RxSwift

final class NetworkService<T: TargetType> {
    
    private let provider: MoyaProvider<T>
    private let disposeBag: DisposeBag = .init()
    
    init(provider: MoyaProvider<T> = MoyaProvider<T>()) {
        self.provider = provider
    }
    
    func fetch<U: Codable>(_ api: T, responseObject: U.Type) -> Single<U> {
        return provider.rx.request(api)
            .filterSuccessfulStatusCodes()
            .map(U.self)
            .catch { error in
                if let moyaError = error as? MoyaError {
                    switch moyaError {
                        case .jsonMapping, .objectMapping:
                            throw APIError.invalidJSON
                        case .statusCode(let response):
                            throw APIError.serverError(.init(responseCode: response.statusCode))
                        case .underlying(let underlyingError, _):
                            let error = underlyingError as NSError
                            if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                                throw APIError.networkUnavailable
                            }
                            throw underlyingError
                        default:
                            throw APIError.unknown
                    }
                } else {
                    throw APIError.unknown
                }
            }
    }
}
