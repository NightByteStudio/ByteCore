//
//  RMRepositoryTests.swift
//  ByteCoreTests
//
//  Created by Nico Christian on 31/10/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import XCTest
import Nimble
import RxSwift
@testable import ByteCore

internal final class RMRepositoryTests: XCTestCase {
    private var mockRMNetworkService: MockRMNetworkService<RMAPI>!
    private var rmRepository: RMRepository!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        mockRMNetworkService = .init()
        rmRepository = DefaultRMRepository(networkService: mockRMNetworkService)
        disposeBag = .init()
    }
    
    override func tearDown() {
        mockRMNetworkService = nil
        rmRepository = nil
        disposeBag = nil
        super.tearDown()
    }
    
    internal func testGetCharacters_Success() {
        mockRMNetworkService.characters = RMPaginatedResponse(results: [.init(id: 1, name: "Rick")])
        
        waitUntil { [weak self] done in
            guard let self = self else { return }
            
            self.rmRepository.getCharacters().subscribe(onSuccess: { response in
                if let response = response, let characters = response.results {
                    expect(characters).toNot(beEmpty())
                    done()
                } else {
                    fail("Found nil in response or response.result")
                    done()
                }
            }, onFailure: { error in
                fail("Expected success but got \(error) instead")
            })
            .disposed(by: self.disposeBag)
        }
    }
    
    internal func testGetCharacter_Success() {
        mockRMNetworkService.character = .init(id: 1, name: "Rick")
        
        self.rmRepository.getCharacterDetail(id: 1).subscribe(onSuccess: { character in
            if let character = character {
                expect(character.name).to(equal("Rick"))
            } else {
                fail("Found character to be nil")
            }
        }, onFailure: { error in
            fail("Expected success but got \(error) instead")
        })
        .disposed(by: disposeBag)
    }
}
