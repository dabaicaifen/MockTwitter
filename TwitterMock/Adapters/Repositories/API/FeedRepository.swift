//
//  FeedRepository.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RxSwift

protocol FeedRepository: class {
    var isEmpty: Bool { get }
    var changes: Observable<FeedChanges> { get }
    func getCount() -> Int
    func save(_ feed: Feed)
    func save(_ feeds: Feeds)
}
