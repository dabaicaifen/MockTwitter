//
//  QueryBuilderTest.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

import XCTest
@testable import TwitterMock

class QueryBuilderTest: XCTestCase {
    
    private let sut = QueryBuilder()
    
    func testEqual() {
        let query = sut
            .equal("name", "someone")
            .build()
        XCTAssertEqual(query, "name = 'someone'")
    }
    
    func testNotEqual() {
        let query = sut
            .notEqual("name", "someone")
            .build()
        XCTAssertEqual(query, "name != 'someone'")
    }
    
    func testAnd() {
        let query = sut
            .equal("total", "10")
            .and()
            .equal("duration", "20")
            .build()
        XCTAssertEqual(query, "total = '10' AND duration = '20'")
    }
    
    func testOr() {
        let query = sut
            .equal("total", "10")
            .or()
            .equal("duration", "20")
            .build()
        XCTAssertEqual(query, "total = '10' OR duration = '20'")
    }
    
    func testIsNil() {
        let query = sut
            .isNil("total")
            .build()
        XCTAssertEqual(query, " total = nil ")
    }
    
    func testIsNotNil() {
        let query = sut
            .isNotNil("total")
            .build()
        XCTAssertEqual(query, " total != nil ")
    }
    
    func testAndSubQueries() {
        let query = sut
            .and(subqueries: [
                "amount",
                "total = '10' OR duration = '20'"
                ])
            .build()
        
        let expectedQuery = " ( amount )  AND  ( total = '10' OR duration = '20' ) "
        XCTAssertEqual(query, expectedQuery)
    }
    
    func testGreaterThan() {
        let query = sut
            .isGreater("total", than: 10)
            .build()
        XCTAssertEqual(query, "total > 10")
    }
}
