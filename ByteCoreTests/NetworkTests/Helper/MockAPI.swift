//
//  MockAPI.swift
//  ByteCoreTests
//
//  Created by Nico Christian on 19/10/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import Moya

internal enum MockAPI: TargetType {
    case mockEndpoint
    
    var baseURL: URL {
        switch self {
            case .mockEndpoint:
                return URL(string: "https://api.nightbyte.id")!
        }
    }
    
    var path: String {
        switch self {
            case .mockEndpoint:
                return "/mock"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .mockEndpoint:
                return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
            case .mockEndpoint:
                return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
            case .mockEndpoint:
                return nil
        }
    }
}
