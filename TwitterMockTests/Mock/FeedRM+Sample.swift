//
//  FeedRM+Sample.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

@testable import TwitterMock

extension FeedRM {
    
    static func sample(id: Int = 123,
                       user: UserRM? = UserRM.sample(),
                       message: String? = "message") -> FeedRM {
        let feedRM = FeedRM()
        feedRM.id = id
        feedRM.user = user
        feedRM.message = message
        return feedRM
    }
    
}
