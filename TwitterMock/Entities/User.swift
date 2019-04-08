//
//  User.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: Int = 0
    var username: String?
    var password: String?
    var avatarUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case username
        case password
        case avatarUrl
    }
    
    static func empty() -> User {
        return User(id: -1,
                    username: "",
                    password: "",
                    avatarUrl: "")
    }
}

typealias Users = [User]
