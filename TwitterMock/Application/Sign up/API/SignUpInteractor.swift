//
//  SignUpInteractor.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-01.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RxSwift

protocol SignUpInteractor: class {
    func signUp(username: String, password: String) -> Observable<MockResult>
}
