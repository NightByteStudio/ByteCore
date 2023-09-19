//
//  RMAPI.swift
//  ByteCore
//
//  Created by Nico on 19/09/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import Foundation
import Moya

enum RMAPI: TargetType {
    static let baseURLString: String = "https://rickandmortyapi.com/"
    
    case getCharacters
    case getCharacter(Int)
    
    var url: URL {
        return URL(string: RMAPI.baseURLString + path)!
    }
    
    var baseURL: URL {
        return URL(string: RMAPI.baseURLString)!
    }
    
    var path: String {
        switch self {
            case .getCharacters:
                return "api/character/"
            case .getCharacter(let id):
                return "api/character/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .getCharacters, .getCharacter:
                return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
            case .getCharacters, .getCharacter:
                return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
