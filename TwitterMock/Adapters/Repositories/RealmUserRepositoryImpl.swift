//
//  RealmPosterRepositoryImpl.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-03.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RealmSwift
import RxRealm
import RxSwift

final class RealmUserRepositoryImpl: UserRepository {
    
    var isEmpty: Bool {
        return UserRMDAO().isEmpty
    }
    
    var changes: Observable<UserChanges> {
        return getChanges()
    }
    
    private var userRMDAO: UserRMDAO {
        return UserRMDAO(inMemoryIdentifier: inMemoryIdentifier)
    }
    
    private let inMemoryIdentifier: String?
    
    init(inMemoryIdentifier: String? = nil) {
        self.inMemoryIdentifier = inMemoryIdentifier
    }
    
    func getUser(by id: Int) -> User? {
        return userRMDAO.getCopy(forPrimaryKey: id)
            .map { $0.toUser() }
    }
    
    func getCount() -> Int {
        return userRMDAO.count
    }
    
    func save(_ user: User) {
        let userRm = UserRM.create(from: user)
        userRMDAO.save(model: userRm)
    }
    
    func save(_ users: Users) {
        users.forEach { save($0) }
    }
    
    private func getChanges() -> Observable<UserChanges> {
        return Observable.changeset(from: getAllSorted())
            .map { result, changeset in
                return UserChanges(items: result.map { $0.toUser() },
                                   changeset: changeset?.toEntityChangeset())
        }
    }
    
    private func getAllSorted() -> Results<UserRM> {
        return userRMDAO.all().sorted(byKeyPath: "id", ascending: false)
    }
    
}
