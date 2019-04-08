//
//  LogoutInteractorMock.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

import RxSwift
@testable import TwitterMock

class LogoutInteractorMock: LogoutInteractor {
    
    func logout() -> Observable<MockResult> {
        return .just(.unknown)
    }
    
}
