//
//  UserDAOTest.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

import XCTest
import RealmSwift
@testable import TwitterMock

class UserDAOTest: XCTestCase {
    
    var dao: RealmDAO<UserRM>!
    
    override func setUp() {
        super.setUp()
        
        dao = RealmDAO<UserRM>(inMemoryIdentifier: String(describing: self))
    }
    
    override func tearDown() {
        dao.reset()
        super.tearDown()
    }
    
    func testSaveAndLoad() {
        XCTAssertEqual(dao.count, 0)
        
        let userRM = UserRM()
        userRM.id = 100
        
        dao.save(model: userRM)
        XCTAssertEqual(dao.count, 1)
        
        let first = dao.first()!
        XCTAssertEqual(first.id, 100)
    }
}

