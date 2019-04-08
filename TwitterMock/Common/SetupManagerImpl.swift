//
//  SetupManagerImpl.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-04.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RxSwift

final class SetupManagerImpl: SetupManager {
    
    private let mockServerService: MockServerService!
    private let feedRepository: FeedRepository!
    private let userRepository: UserRepository!
    
    private let userDefault = UserDefaults.standard
    private let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    private let disposeBag = DisposeBag()
    
    init(mockServerService: MockServerService,
         feedRepository: FeedRepository,
         userRepository: UserRepository) {
        self.mockServerService = mockServerService
        self.userRepository = userRepository
        self.feedRepository = feedRepository
    }
    
    func startMainUI() {
        if self.alreadySignIn() {
            ScreenManager.shared.displayFeedsScreen()
        } else {
            ScreenManager.shared.displaySignInScreen()
        }
    }
    
    func alreadySignIn() -> Bool {
        if getToken() == nil {
            return false
        }
        
        let id = getCurrentUserId() ?? 0
        let user = userRepository.getUser(by: id)
        DataCenter.shared.setCurrent(user: user)
        return true
    }
    
    func setToken(_ token: String) {
        userDefault.set(token, forKey: "token")
    }
    
    func getToken() -> String? {
        return userDefault.value(forKey: "token") as? String
    }
    
    func clearToken() {
        userDefault.removeObject(forKey: "token")
    }
    
    func setCurrentUser(id: Int) {
        userDefault.set(id, forKey: "currentUserId")
    }
    
    func getCurrentUserId() -> Int? {
        return userDefault.value(forKey: "currentUserId") as? Int
    }

}
