//
//  Task+Ext.swift
//  ByteCoreTests
//
//  Created by Nico Christian on 31/10/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import Moya

/**
 * An extension for Moya.Task to conform to Equatable
 * For the sole purpose of validating the case for unit tests
 */
extension Moya.Task: Equatable {
    public static func == (lhs: Moya.Task, rhs: Moya.Task) -> Bool {
        switch (lhs, rhs) {
            case (.requestPlain, .requestPlain):
                return true
            case (.requestData, .requestData):
                return true
            case (.requestJSONEncodable, .requestJSONEncodable):
                return true
            case (.requestCustomJSONEncodable, .requestCustomJSONEncodable):
                return true
            case (.requestParameters, .requestParameters):
                return true
            case (.requestCompositeData, .requestCompositeData):
                return true
            case (.requestCompositeParameters, .requestCompositeParameters):
                return true
            case (.uploadFile, .uploadFile):
                return true
            case (.uploadMultipart, .uploadMultipart):
                return true
            case (.uploadCompositeMultipart, .uploadCompositeMultipart):
                return true
            case (.downloadDestination, .downloadDestination):
                return true
            case (.downloadParameters, .downloadParameters):
                return true
            default:
                return false
        }
    }
}
