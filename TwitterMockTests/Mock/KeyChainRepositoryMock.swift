//
//  KeyChainRepositoryMock.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
@testable import TwitterMock

class KeyChainRepositoryMock: KeyChainRepository {

    var encryptionKey: Data?
    
    func getData(identifier: KeyChainIdentifier) -> Data? {
        return encryptionKey
    }
    
    func setData(identifier: KeyChainIdentifier, with data: Data) {
        encryptionKey = data
    }
    
    func removeData(identifier: KeyChainIdentifier) {}

    func isEmpty(identifier: KeyChainIdentifier) -> Bool {
        return true
    }
    
}
