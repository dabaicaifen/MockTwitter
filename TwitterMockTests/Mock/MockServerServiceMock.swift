//
//  MockServerServiceMock.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

import RxSwift
@testable import TwitterMock

class MockServerServiceMock: MockServerService {
    
    func signUp(username: String, password: String) -> Observable<MockResult> {
        return .just(.unknown)
    }
    
    func signIn(username: String, password: String) -> Observable<MockResult> {
        return .just(.unknown)
    }
    
    func getFeeds(since: Int?) -> Observable<MockResult> {
        return .just(.unknown)
    }
    
    func postFeed(_ data: Data) -> Observable<MockResult> {
        return .just(.unknown)
    }

}
