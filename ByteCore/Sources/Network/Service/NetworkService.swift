//
//  NetworkService.swift
//  ByteCore
//
//  Created by Nico Christian on 13/09/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import Moya
import RxSwift

/**
 * Generic reusable NetworkService object
 * T is constraint for Moya's TargetType API
 * U is constraint to Codable. It is the expected return object from the server and to be mapped accordingly
 * The fetch method is open to be override just in case the subclass needs extra implementation
 * The fetch method will call the API, returns the mapped object or return an API error if there are any occured
 *
 * NOTE: This object uses the Moya/RxSwift extensions
 */
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
