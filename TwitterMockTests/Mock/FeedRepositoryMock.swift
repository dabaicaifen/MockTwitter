//
//  FeedRepositoryMock.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

import RxSwift
@testable import TwitterMock

class FeedRepositoryMock: FeedRepository {
    var isEmpty: Bool
    
    var changes: Observable<FeedChanges>
    
    init() {
        isEmpty = false
        changes = Observable.just(FeedChanges.empty())
    }
    
    func getCount() -> Int {
        return 0
    }
    
    func save(_ feed: Feed) { }
    
    func save(_ feeds: Feeds) {}

}
