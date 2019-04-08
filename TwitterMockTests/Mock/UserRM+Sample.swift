//
//  UserRM+Sample.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

@testable import TwitterMock

extension UserRM {
    
    static func sample(id: Int = 123,
                       username: String? = "name") -> UserRM {
        let userRM = UserRM()
        userRM.id = id
        userRM.username = username
        return userRM
    }
    
}
