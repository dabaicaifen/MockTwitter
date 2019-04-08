//
//  FeedRM+ConvertTest.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

import XCTest
@testable import TwitterMock

class FeedRM_ConvertTest: XCTestCase {
    
    func testConvertToFeed() {
        let feedRM = FeedRM.sample(id: 123, user: nil, message: "test")
        let feed = feedRM.toFeed()
        
        XCTAssertEqual(feedRM.id, feed.id)
        XCTAssertEqual(feedRM.message, feed.message)
    }
    
}
