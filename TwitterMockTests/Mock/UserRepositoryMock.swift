//
//  UserRepositoryMock.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

import RxSwift
@testable import TwitterMock

class UserRepositoryMock: UserRepository {
    
    var isEmpty: Bool
    
    var changes: Observable<UserChanges>
    
    init() {
        isEmpty = false
        changes = Observable.just(UserChanges.empty())
    }
    
    func getUser(by id: Int) -> User? {
        return nil
    }
    
    func getCount() -> Int {
        return 0
    }
    
    func save(_ user: User) {}
    
    func save(_ users: Users) {}

}
