//
//  NetworkError.swift
//  ByteCore
//
//  Created by Nico Christian on 13/09/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

/**
 * APIError is an enum to handle different types of error the NetworkService might catch
 * networkUnavailable: A case where the device is not connected to the internet
 * serverError(ServerError): A case where the server returns an error, this will contains a ServerError object with the response code and error message
 * invalidJSON: A case where the return object from the server is unexpectedly different than what the front-end anticipates
 * unknown: Any other error that might occur. Should provide a general message from when this occurs
 */
public enum APIError: Error {
  case networkUnavailable
  case serverError(ServerError)
  case invalidJSON
  case unknown
}
