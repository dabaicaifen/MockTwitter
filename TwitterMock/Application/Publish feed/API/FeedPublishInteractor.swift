//
//  FeedPublishInteractor.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-03.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RxSwift

protocol FeedPublishInteractor: class {
    func postFeed(message: String, image: String) -> Observable<MockResult>
}
