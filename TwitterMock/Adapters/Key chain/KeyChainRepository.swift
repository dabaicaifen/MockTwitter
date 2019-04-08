//
//  KeyChainRepository.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

enum KeyChainIdentifier: String {
    case realmEncryptionKey = "encryption.db.key"
}

protocol KeyChainRepository: class {
    func getData(identifier: KeyChainIdentifier) throws -> Data?
    func setData(identifier: KeyChainIdentifier, with data: Data) throws
    func removeData(identifier: KeyChainIdentifier) throws
    func isEmpty(identifier: KeyChainIdentifier) -> Bool
}
