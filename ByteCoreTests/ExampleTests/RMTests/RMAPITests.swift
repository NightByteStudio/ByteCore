//
//  RMAPITests.swift
//  ByteCoreTests
//
//  Created by Nico Christian on 31/10/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import XCTest
import Nimble
@testable import ByteCore

internal final class RMAPITests: XCTestCase {
    func testGetCharactersAPI() {
        let api: RMAPI = .getCharacters
        
        expect(api.url.absoluteString).to(equal("https://rickandmortyapi.com/api/character/"))
        expect(api.baseURL.absoluteString).to(equal("https://rickandmortyapi.com/"))
        expect(api.path).to(equal("api/character/"))
        expect(api.method).to(equal(.get))
        expect(api.task).to(equal(.requestPlain))
        expect(api.headers).to(beNil())
    }
    
    func testGetCharacterAPI() {
        let api: RMAPI = .getCharacter(1)
        
        expect(api.url.absoluteString).to(equal("https://rickandmortyapi.com/api/character/1"))
        expect(api.baseURL.absoluteString).to(equal("https://rickandmortyapi.com/"))
        expect(api.path).to(equal("api/character/1"))
        expect(api.method).to(equal(.get))
        expect(api.task).to(equal(.requestPlain))
        expect(api.headers).to(beNil())
    }
}
