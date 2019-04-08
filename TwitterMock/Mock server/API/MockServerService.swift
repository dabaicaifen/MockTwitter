//
//  MockServerService.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RxSwift

protocol MockServerService: class {
    // User service
    func signUp(username: String, password: String) -> Observable<MockResult>
    func signIn(username: String, password: String) -> Observable<MockResult>
    
    // Feed service
    func getFeeds(since: Int?) -> Observable<MockResult>
    func postFeed(_ data: Data) -> Observable<MockResult>
}
