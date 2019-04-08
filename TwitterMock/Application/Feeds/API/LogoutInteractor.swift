//
//  LogoutInteractor.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-04.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RxSwift

protocol LogoutInteractor: class {
    func logout() -> Observable<MockResult>
}
