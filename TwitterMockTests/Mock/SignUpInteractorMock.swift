//
//  SignUpInteractorMock.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

import RxSwift
@testable import TwitterMock

class SignUpInteractorMock: SignUpInteractor {
    
    func signUp(username: String, password: String) -> Observable<MockResult> {
        return .just(.unknown)
    }
    
}
