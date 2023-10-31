//
//  MockMoyaProvider.swift
//  ByteCoreTests
//
//  Created by Nico Christian on 19/10/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import Moya

internal final class MockMoyaProvider<T: TargetType>: MoyaProvider<T> {
    var testResult: Result<Response, MoyaError>!

    override func request(_ token: T, callbackQueue: DispatchQueue? = .none, progress: Moya.ProgressBlock? = .none, completion: @escaping Moya.Completion) -> Cancellable {
        completion(testResult)
        return SimpleCancellable()
    }
}
