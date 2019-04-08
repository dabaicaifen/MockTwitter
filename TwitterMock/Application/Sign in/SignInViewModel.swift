//
//  SignInViewModel.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-01.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class SignInViewModel {
    
    let signInButtonEnable = BehaviorRelay(value: false)
    let username = BehaviorRelay(value: "")
    let password = BehaviorRelay(value: "")
    
    var signInResult: Observable<Bool> {
        return signInResultSubject
    }
    
    private let signInInteractor: SignInInteractor!
    private let signInResultSubject = PublishSubject<Bool>()
    private let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    private let disposeBag = DisposeBag()
    
    init(signInInteractor: SignInInteractor) {
        self.signInInteractor = signInInteractor
        self.setupObservable()
    }
    
    func signIn() {
        signInInteractor
            .signIn(username: username.value, password: password.value)
            .observeOn(scheduler)
            .subscribe (onNext: { [weak self] result in
                guard let `self` = self else { return }
                
                switch result {
                case .success(_):
                    self.signInResultSubject.onNext(true)
                case .failed(_):
                    self.signInResultSubject.onNext(false)
                default:
                    self.signInResultSubject.onNext(false)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupObservable() {
        Observable.combineLatest(
            username.asObservable(),
            password.asObservable()
            )
            .observeOn(scheduler)
            .skip(1)
            .subscribe (onNext: { [weak self] username, password in
                if username != "" && password != "" {
                    self?.signInButtonEnable.accept(true)
                } else {
                    self?.signInButtonEnable.accept(false)
                }
            })
            .disposed(by: disposeBag)
    }
    
}
