//
//  RMAPI.swift
//  ByteCore
//
//  Created by Nico on 19/09/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import Moya

internal enum RMAPI: TargetType {
    internal static let baseURLString: String = "https://rickandmortyapi.com/"
    
    case getCharacters
    case getCharacter(Int)
    
    internal var url: URL {
        return URL(string: RMAPI.baseURLString + path)!
    }
    
    internal var baseURL: URL {
        return URL(string: RMAPI.baseURLString)!
    }
    
    internal var path: String {
        switch self {
            case .getCharacters:
                return "api/character/"
            case .getCharacter(let id):
                return "api/character/\(id)"
        }
    }
    
    internal var method: Moya.Method {
        switch self {
            case .getCharacters, .getCharacter:
                return .get
        }
    }
    
    internal var task: Moya.Task {
        switch self {
            case .getCharacters, .getCharacter:
                return .requestPlain
        }
    }
    
    internal var headers: [String : String]? {
        return nil
    }
}
