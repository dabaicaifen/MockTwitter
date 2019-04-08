//
//  DataCenter.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-04.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

final class DataCenter {
    
    static let shared = DataCenter()
    
    private(set) var currentUser: User?

    func setCurrent(user: User?) {
        currentUser = user
    }
    
    private init() {}
    
}
