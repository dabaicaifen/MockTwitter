//
//  QueryBuilder.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

final class QueryBuilder {
    
    private var query = ""
    
    func equal(_ property: String, _ value: Int) -> QueryBuilder {
        return equal(property, string: "\(value)")
    }
    
    func equal(_ property: String, _ value: Bool) -> QueryBuilder {
        return equal(property, string: "\(value)")
    }
    
    func equal(_ property: String, _ value: Int64) -> QueryBuilder {
        return equal(property, string: "\(value)")
    }
    
    func equal(_ property: String, _ value: String) -> QueryBuilder {
        return equal(property, string: "'\(value)'")
    }
    
    func equal(_ property: String, string value: String) -> QueryBuilder {
        return append("\(property) = \(value)")
    }
    
    func notEqual(_ property: String, _ value: String) -> QueryBuilder {
        return notEqual(property, string: "'\(value)'")
    }
    
    func notEqual(_ property: String, string value: String) -> QueryBuilder {
        return append("\(property) != \(value)")
    }
    
    func isGreater(_ property: String, than value: Int) -> QueryBuilder {
        return append("\(property) > \(value)")
    }
    
    func isGreater(_ property: String, than value: Int64) -> QueryBuilder {
        return append("\(property) > \(value)")
    }
    
    func and() -> QueryBuilder {
        return append(" AND ")
    }
    
    func or() -> QueryBuilder {
        return append(" OR ")
    }
    
    func isNil(_ property: String) -> QueryBuilder {
        return append(" \(property) = nil ")
    }
    
    func isNotNil(_ property: String) -> QueryBuilder {
        return append(" \(property) != nil ")
    }
    
    func and(subqueries: [String]) -> QueryBuilder {
        query.append(subqueries.map(wrapInParenthesis).joined(separator: " AND "))
        return self
    }
    
    func append(_ subquery: String) -> QueryBuilder {
        query.append(subquery)
        return self
    }
    
    func build() -> String {
        return query
    }
    
    private func wrapInParenthesis(subquery: String) -> String {
        return " ( " + subquery + " ) "
    }
    
}
