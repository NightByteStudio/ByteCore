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

open class NetworkService<T: TargetType> {
    
    private let provider: MoyaProvider<T>
    private let disposeBag: DisposeBag = .init()
    
    public init(provider: MoyaProvider<T> = MoyaProvider<T>()) {
        self.provider = provider
    }
    
    open func fetch<U: Codable>(_ api: T, responseObject: U.Type) -> Single<U> {
        return provider.rx.request(api)
            .filterSuccessfulStatusCodes()
            .map(U.self)
            .catch { error in
                if let moyaError = error as? MoyaError {
                    switch moyaError {
                        case .jsonMapping, .objectMapping:
                            throw APIError.invalidJSON
                        case let .statusCode(response):
                            throw APIError.serverError(.init(responseCode: response.statusCode))
                        case let .underlying(underlyingError, _):
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
