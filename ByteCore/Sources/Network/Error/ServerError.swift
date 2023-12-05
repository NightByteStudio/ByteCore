//
//  ServerError.swift
//  ByteCore
//
//  Created by Nico Christian on 13/09/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

/**
 * ServerError is type that will be initialized and returned to the view model when the NetworkService receives an error
 *  responseCode should contains HTTP Response Code from the server
 *  message should contains the error message returned by the server
 */
public struct ServerError: Error {
    public var responseCode: Int?
    public var message: String?
}
