//
//  setupManagerMock.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

@testable import TwitterMock

class SetupManagerMock: SetupManager {
    
    var tokenIsCleared = false
    
    func startMainUI() {}
    
    func alreadySignIn() -> Bool {
        return false
    }
    
    func setToken(_ token: String) {}
    
    func getToken() -> String? {
        return nil
    }
    
    func clearToken() {
        tokenIsCleared = true
    }
    
    func setCurrentUser(id: Int) {}
    
    func getCurrentUserId() -> Int? {
        return 0
    }
    
}
