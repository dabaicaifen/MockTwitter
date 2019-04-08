//
//  RealmStorageSetupImpl.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmStorageSetupImpl: RealmStorageSetup {
    
    private let keyChainRepository: KeyChainRepository!
    
    init(keyChainRepository: KeyChainRepository) {
        self.keyChainRepository = keyChainRepository
        self.generateAndStoreEncryptionKeyIfEmpty()
    }
    
    func setup(inMemoryIdentifier: String? = nil) {
        setupEncryptionConfig()
        initialOpenRealm(inMemoryIdentifier: inMemoryIdentifier)
    }
    
    private func initialOpenRealm(inMemoryIdentifier: String? = nil) {
        do {
            _ = try Realm.create(with: inMemoryIdentifier)
        }
        catch {
            print("[Realm] Unexpected error: \(error.localizedDescription)")
            removeExistingRealmFile()
            fatalError(error.localizedDescription)
        }
    }
    
    private func setupEncryptionConfig() {
        do {
            if let encryptionKey = try getEncryptionKey() {
                Realm.setup(encryptionKey: encryptionKey)
            } else {
                throw RealmSetupError(message: "require encryption key")
            }
        }
        catch {
            print("[Realm] Unexpected error: \(error.localizedDescription)")
            fatalError(error.localizedDescription)
        }
    }
    
    private func getEncryptionKey() throws -> Data? {
        return try keyChainRepository.getData(identifier: KeyChainIdentifier.realmEncryptionKey)
    }
    
    private func generateAndStoreEncryptionKeyIfEmpty() {
        // delete key chain if need
        // try! keyChainRepository.removeData(identifier: KeyChainIdentifier.realmEncryptionKey)
        if keyChainRepository.isEmpty(identifier: KeyChainIdentifier.realmEncryptionKey) {
            try! keyChainRepository.setData(identifier: KeyChainIdentifier.realmEncryptionKey,
                                            with: RealmStorageSetupImpl.generateEncryptionKey())
        }
    }
    
    private func removeExistingRealmFile() {
        guard let realmFileUrl = Realm.Configuration.defaultConfiguration.fileURL else { return }
        
        do {
            try FileManager.default.removeItem(at: realmFileUrl)
        }
        catch {
            print("[Realm] Unexpected error: \(error.localizedDescription)")
        }
    }
    
    private static func generateEncryptionKey() -> Data {
        var key = Data(count: 64)
        _ = key.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, 64, $0.baseAddress!)
        }
        
        return key
    }
}
