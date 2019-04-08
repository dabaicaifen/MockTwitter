//
//  EntityChanges.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-03.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

struct EntityChanges<T> {
    let items: [T]
    let changeset: Changeset?
    
    static func empty() -> EntityChanges<T> {
        return EntityChanges<T>(items: [],
                                changeset: Changeset.empty())
    }
}
