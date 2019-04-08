//
//  LogoutInteractorImpl.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-04.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RxSwift

final class LogoutInteractorImpl: LogoutInteractor {
    
    private let serverService: MockServerService!
    private let setupManager: SetupManager!
    private let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    
    init(serverService: MockServerService, setupManager: SetupManager) {
        self.serverService = serverService
        self.setupManager = setupManager
    }
    
    func logout() -> Observable<MockResult> {
        return Observable.create({ [weak self] observer in
            self?.setupManager.clearToken()
            let data = "Log out success".data(using: .utf8)!
            observer.onNext(.success(data: data))
            observer.onCompleted()
            return Disposables.create()
        })
            .subscribeOn(scheduler)
    }
    
}
