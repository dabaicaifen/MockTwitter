//
//  UserRepository.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-03.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RxSwift

protocol UserRepository: class {
    var isEmpty: Bool { get }
    var changes: Observable<UserChanges> { get }
    func getUser(by id: Int) -> User?
    func getCount() -> Int
    func save(_ user: User)
    func save(_ users: Users)
}
