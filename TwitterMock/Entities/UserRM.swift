//
//  UserRM.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RealmSwift

final class UserRM: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var username: String?
    @objc dynamic var avatarUrl: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func create(from user: User) -> UserRM {
        let userRM = UserRM()
        userRM.id = user.id
        user.username.map { userRM.username = $0 }
        user.avatarUrl.map { userRM.avatarUrl = $0 }
        return userRM
    }
    
    func toUser() -> User {
        return User(id: id,
                    username: username ?? "",
                    password: "",
                    avatarUrl: avatarUrl)
    }
}
