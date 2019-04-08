//
//  RealmSetup.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - Realm Setup
extension Realm {
    
    static func setup(encryptionKey: Data) {
        // Debug only
        // print("key is : \(encryptionKey.hexEncodedString())")
        Realm.Configuration.defaultConfiguration = createConfig(encryptionKey: encryptionKey)
    }
    
    static func cleanUp(_ entities: [Object.Type]) {
        let realm = Realm.tryCreate()
        
        try! realm.write {
            for entity in entities {
                realm.delete(realm.objects(entity))
            }
        }
    }
    
    private static func createConfig(encryptionKey: Data) -> Realm.Configuration {
        return Realm.Configuration(
            fileURL: RealmConfigurationValues.fileURL,
            encryptionKey: encryptionKey,
            schemaVersion: RealmConfigurationValues.schemaVersion,
            deleteRealmIfMigrationNeeded: true,
            shouldCompactOnLaunch: { totalBytes, usedBytes in
                let oneHundredMB = 100 * 1024 * 1024
                return (totalBytes > oneHundredMB) && (Double(usedBytes) / Double(totalBytes)) < 0.5
        })
    }
}

// MARK: - Realm Configuration
struct RealmConfigurationValues {
    static let schemaVersion: UInt64 = 1
    
    static var fileURL: URL {
        let libraryPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory,
                                                              .userDomainMask,
                                                              true).first ?? ""
        print("path: \(libraryPath)")
        return URL(fileURLWithPath: libraryPath).appendingPathComponent("db.realm")
    }
}
