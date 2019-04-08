//
//  SignInInteractorImpl.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-01.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RxSwift

final class SignInInteractorImpl: SignInInteractor {
    
    private let serverService: MockServerService!
    private let setupManager: SetupManager!
    private let feedRefreshInteractor: FeedRefreshInteractor!
    private let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    
    init(serverService: MockServerService,
         setupManager: SetupManager,
         feedRefreshInteractor: FeedRefreshInteractor) {
        self.serverService = serverService
        self.setupManager = setupManager
        self.feedRefreshInteractor = feedRefreshInteractor
    }
    
    func signIn(username: String, password: String) -> Observable<MockResult> {
        return serverService.signIn(username: username, password: password)
            .observeOn(scheduler)
            .do(onNext: { [weak self] result in
                guard let `self` = self else { return }
                
                switch result {
                case .success(let data):
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        self.setupManager.setToken(json["token"]! as! String)
                        self.setupManager.setCurrentUser(id: json["id"] as! Int)
                        self.feedRefreshInteractor.refreshFeeds(since: nil)
                    }
                    catch {
                        print("JSON Serialization error: \(error.localizedDescription)")
                    }
                case .failed(let reason):
                    print("[Server] error: \(reason)")
                default: break
                }
            })
    }
    
}
