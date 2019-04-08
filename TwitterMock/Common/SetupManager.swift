//
//  SetupManager.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-04.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

protocol SetupManager: class {
    func startMainUI()
    func alreadySignIn() -> Bool
    func setToken(_ token: String)
    func getToken() -> String?
    func clearToken()
    func setCurrentUser(id: Int)
    func getCurrentUserId() -> Int?
}
