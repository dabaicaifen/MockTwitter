//
//  Realm+Util.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    
    static func tryCreate(with inMemoryIdentifier: String? = nil) -> Realm {
        var realm: Realm?
        do {
            realm = try create(with: inMemoryIdentifier)
        }
        catch {
            print("[Realm] Unexpected error: \(error.localizedDescription).")
            fatalError(error.localizedDescription)
        }
        return realm!
    }
    
    static func create(with inMemoryIdentifier: String? = nil) throws -> Realm {
        guard let inMemoryIdentifier = inMemoryIdentifier else {
            return try Realm()
        }
        let configuration = Realm.Configuration(inMemoryIdentifier: inMemoryIdentifier)
        return try Realm(configuration: configuration)
    }
    
    func tryWrite(writeBlock: ()->()) {
        do {
            try self.write { writeBlock() }
        }
        catch {
            print("[Realm] Unexpected error: \(error).")
        }
    }
    
}
