//
//  FeedDAOTest.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

import XCTest
import RealmSwift
@testable import TwitterMock

class FeedDAOTest: XCTestCase {
    
    var dao: RealmDAO<FeedRM>!
    
    override func setUp() {
        super.setUp()
        
        dao = RealmDAO<FeedRM>(inMemoryIdentifier: String(describing: self))
    }
    
    override func tearDown() {
        dao.reset()
        super.tearDown()
    }
    
    func testSaveAndLoad() {
        XCTAssertEqual(dao.count, 0)
        
        let feedRM = FeedRM()
        feedRM.id = 100
        
        dao.save(model: feedRM)
        XCTAssertEqual(dao.count, 1)
        
        let first = dao.first()!
        XCTAssertEqual(first.id, 100)
    }
}
