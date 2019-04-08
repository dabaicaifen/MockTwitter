//
//  UserRM+ConvertTest.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

import XCTest
@testable import TwitterMock

class UserRM_ConvertTest: XCTestCase {
    
    func testConvertToUser() {
        let userRM = UserRM.sample(id: 123, username: "test")
        let user = userRM.toUser()
        
        XCTAssertEqual(userRM.id, user.id)
        XCTAssertEqual(userRM.username, user.username)
    }

}
