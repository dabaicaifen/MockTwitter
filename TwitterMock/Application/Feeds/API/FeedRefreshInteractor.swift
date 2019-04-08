//
//  FeedRefreshInteractor.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-06.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

protocol FeedRefreshInteractor: class {
    func refreshFeeds(since id: Int?)
}
