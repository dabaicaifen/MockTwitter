//
//  KeyChainRepositoryImpl.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import KeychainAccess

final class KeyChainRepositoryImpl: KeyChainRepository {
    
    private let keychain: Keychain
    
    init(service: String? = Bundle.main.bundleIdentifier) {
        keychain = Keychain(service: service ?? "")
    }
    
    func getData(identifier: KeyChainIdentifier) throws -> Data? {
        return try keychain.getData(identifier.rawValue)
    }
    
    func setData(identifier: KeyChainIdentifier, with data: Data) throws {
        try keychain.set(data, key: identifier.rawValue)
    }
    
    func removeData(identifier: KeyChainIdentifier) throws {
        return try keychain.remove(identifier.rawValue)
    }
    
    func isEmpty(identifier: KeyChainIdentifier) -> Bool {
        do {
            return try keychain.getData(identifier.rawValue) == nil
        }
        catch {
            return true
        }
    }
}
