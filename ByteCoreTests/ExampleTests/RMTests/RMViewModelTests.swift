//
//  RMViewModelTests.swift
//  ByteCoreTests
//
//  Created by Nico Christian on 31/10/23.
//  Copyright © 2023 NightByteStudio. All rights reserved.
//

import XCTest
import Nimble
import RxSwift
@testable import ByteCore

internal final class RMViewModelTests: XCTestCase {
    private var mockRMRepository: MockRMRepository!
    private var rmViewModel: RMViewModel!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        mockRMRepository = .init()
        rmViewModel = .init(repository: mockRMRepository)
        disposeBag = .init()
    }
    
    override func tearDown() {
        mockRMRepository = nil
        rmViewModel = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func testGetCharacters_Success() {
        mockRMRepository.charactersResponse = RMPaginatedResponse(results: [.init(id: 1, name: "Rick")])
        
        waitUntil { [weak self] done in
            guard let self = self else { return }
            self.rmViewModel.getCharactersState.subscribe(onNext: { state in
                switch state {
                    case let .success(characters):
                        expect(characters).toNot(beEmpty())
                        done()
                    case let .failed(error):
                        fail("Expected success but got \(error) instead")
                        done()
                    case .empty:
                        fail("Expected success but got empty instead")
                        done()
                    default:
                        break
                }
            }, onError: { error in
                fail("Expected success but got \(error) instead")
            })
            .disposed(by: self.disposeBag)
            
            self.rmViewModel.getCharacters()
        }
    }
    
    func testGetCharacters_Failed() {
        mockRMRepository.error = APIError.networkUnavailable
        
        waitUntil { [weak self] done in
            guard let self = self else { return }
            self.rmViewModel.getCharactersState.subscribe(onNext: { state in
                switch state {
                    case .success:
                        fail("Expected Failed but got success instead")
                        done()
                    case let .failed(error):
                        expect(error).toNot(beNil())
                        done()
                    case .empty:
                        fail("Expected success but got empty instead")
                        done()
                    default:
                        break
                }
            }, onError: { error in
                fail("Expected failed state but got \(error) instead")
            })
            .disposed(by: self.disposeBag)
            
            self.rmViewModel.getCharacters()
        }
    }
    
    func testGetCharacters_Empty() {
        mockRMRepository.charactersResponse = RMPaginatedResponse(results: [])
        
        waitUntil { [weak self] done in
            guard let self = self else { return }
            self.rmViewModel.getCharactersState.subscribe(onNext: { state in
                switch state {
                    case .success:
                        fail("Expected Empty but got Success instead")
                        done()
                    case let .failed(error):
                        fail("Expected Empty but got \(error) instead")
                        done()
                    case .empty:
                        done()
                    default:
                        break
                }
            }, onError: { error in
                fail("Expected success but got \(error) instead")
            })
            .disposed(by: self.disposeBag)
            
            self.rmViewModel.getCharacters()
        }
    }
    
    func testGetCharacterDetail_Success() {
        mockRMRepository.character = .init(id: 1, name: "Rick")
        
        waitUntil { [weak self] done in
            guard let self = self else { return }
            self.rmViewModel.getCharacterDetailState.subscribe(onNext: { state in
                switch state {
                    case let .success(character):
                        expect(character).toNot(beNil())
                        expect(character.name).to(equal("Rick"))
                        done()
                    case let .failed(error):
                        fail("Expected success but got \(error) instead")
                        done()
                    case .empty:
                        fail("Expected success but got empty instead")
                        done()
                    default:
                        break
                }
            }, onError: { error in
                fail("Expected success but got \(error) instead")
            })
            .disposed(by: self.disposeBag)
            
            self.rmViewModel.getCharacterDetail(id: 1)
        }
    }
    
    func testGetCharacterDetail_Failed() {
        mockRMRepository.error = APIError.networkUnavailable
        
        waitUntil { [weak self] done in
            guard let self = self else { return }
            self.rmViewModel.getCharacterDetailState.subscribe(onNext: { state in
                switch state {
                    case .success:
                        fail("Expected Failed but got success instead")
                        done()
                    case let .failed(error):
                        expect(error).toNot(beNil())
                        done()
                    case .empty:
                        fail("Expected success but got empty instead")
                        done()
                    default:
                        break
                }
            }, onError: { error in
                fail("Expected failed state but got \(error) instead")
            })
            .disposed(by: self.disposeBag)
            
            self.rmViewModel.getCharacterDetail(id: 1)
        }
    }
    
    func testGetCharacterDetail_Empty() {
        mockRMRepository.character = nil
        mockRMRepository.error = nil
        
        waitUntil { [weak self] done in
            guard let self = self else { return }
            self.rmViewModel.getCharacterDetailState.subscribe(onNext: { state in
                switch state {
                    case .success:
                        fail("Expected Empty but got Success instead")
                        done()
                    case let .failed(error):
                        fail("Expected Empty but got \(error) instead")
                        done()
                    case .empty:
                        done()
                    default:
                        break
                }
            }, onError: { error in
                fail("Expected success but got \(error) instead")
            })
            .disposed(by: self.disposeBag)
            
            self.rmViewModel.getCharacterDetail(id: 1)
        }
    }
    
    func testGetAllState() {
        let states = rmViewModel.getAllStates()
        expect(states.count).to(equal(2))
    }
}
