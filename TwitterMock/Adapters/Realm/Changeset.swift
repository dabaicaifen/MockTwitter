//
//  Changeset.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-03.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

struct Changeset {
    
    let deletions: [Int]
    let insertions: [Int]
    let modifications: [Int]
    
    var isEmpty: Bool {
        return deletions.isEmpty && insertions.isEmpty && modifications.isEmpty
    }
    
    public static func empty() -> Changeset {
        return Changeset(deletions: [],
                         insertions: [],
                         modifications: [])
    }
    
    static func modifications(_ modifications: [Int]) -> Changeset {
        return Changeset(deletions: [],
                         insertions: [],
                         modifications: modifications)
    }
}
