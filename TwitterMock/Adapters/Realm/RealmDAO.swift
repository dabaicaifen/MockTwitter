//
//  RealmDAO.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDAO<Model: Object> {
    
    var count: Int {
        return realm.objects(Model.self).count
    }
    
    var isEmpty: Bool {
        return all().isEmpty
    }
    
    private let realm: Realm
    
    init(inMemoryIdentifier: String? = nil) {
        realm = Realm.tryCreate(with: inMemoryIdentifier)
    }
    
    func reset() {
        realm.tryWrite {
            realm.delete(all())
        }
    }
    
    func all() -> Results<Model> {
        return realm.objects(Model.self)
    }
    
    func first() -> Model? {
        return all().first
    }
    
    func get(query: String) -> Results<Model> {
        return all().filter(query)
    }
    
    func get(query: NSPredicate) -> Results<Model> {
        return all().filter(query)
    }
    
    func delete(model: Model, cascading: Bool = false) {
        realm.tryWrite {
            realm.delete(model)
        }
    }
    
    func delete(models: [Model]) {
        guard models.count > 0 else { return }
        
        realm.tryWrite {
            realm.delete(models)
        }
    }
    
    func get<KeyType>(forPrimaryKey key: KeyType) -> Model? {
        return realm.object(ofType: Model.self, forPrimaryKey: key)
    }
    
    func getCopy<KeyType>(forPrimaryKey key: KeyType) -> Model? {
        return get(forPrimaryKey: key)?.makeCopy()
    }
    
    func delete<KeyType>(withPrimaryKey key: KeyType) {
        realm.tryWrite {
            if let model = get(forPrimaryKey: key) {
                realm.delete(model) }
        }
    }
    
    func save(model: Model) {
        realm.tryWrite {
            realm.add(model, update: true)
        }
    }
    
    func save(models: [Model]) {
        guard models.count > 0 else { return }
        
        realm.tryWrite {
            realm.add(models, update: true)
        }
    }
    
    func write(writeBlock: ()->()) {
        realm.tryWrite {
            writeBlock()
        }
    }
    
}
