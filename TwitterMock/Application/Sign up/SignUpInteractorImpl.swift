//
//  SignUpInteractorImpl.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-01.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm

final class SignUpInteractorImpl: SignUpInteractor {
    
    private let serverService: MockServerService!
    private let userRepository: UserRepository!
    private let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    
    init(serverService: MockServerService,
         userRepository: UserRepository) {
        self.serverService = serverService
        self.userRepository = userRepository
    }
    
    func signUp(username: String, password: String) -> Observable<MockResult> {
        return serverService.signUp(username: username, password: password)
            .observeOn(scheduler)
            .do(onNext: { [weak self] result in
                switch result {
                case .success(let data):
                    do {
                        let user = try JSONDecoder().decode(User.self, from: data)
                        self?.userRepository.save(user)
                    }
                    catch {
                        print("JSONDecoder error")
                    }
                default: break
                }
            })
    }
    
}
