//
//  RealmStorageSetupImplTest.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

import XCTest
import RealmSwift
@testable import TwitterMock

class RealmStorageSetupImplTest: XCTestCase {
    
    private var sut: RealmStorageSetupImpl!
    
    private let keyChainRepository = KeyChainRepositoryMock()
    
    override func setUp() {
        super.setUp()
        
        sut = RealmStorageSetupImpl(keyChainRepository: keyChainRepository)
    }
    
    func testSetupWithEncryptionKey() {
        sut.setup(inMemoryIdentifier: String(describing: self))
        XCTAssertNotNil(keyChainRepository.encryptionKey)
        XCTAssertEqual(Realm.Configuration.defaultConfiguration.encryptionKey,
                       keyChainRepository.encryptionKey)
    }
}
