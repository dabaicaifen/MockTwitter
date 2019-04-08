//
//  SignUpViewModel.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-01.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class SignUpViewModel {
    
    var signUpResult: Observable<Bool> {
        return signUpResultSubject
    }
    
    var confirmPassword: Observable<Bool> {
        return confirmPasswordSubject
    }
    
    let signUpButtonEnable = BehaviorRelay(value: false)
    let username = BehaviorRelay(value: "")
    let password = BehaviorRelay(value: "")
    let passwordConfirm = BehaviorRelay(value: "")
    
    private let signUpInteractor: SignUpInteractor!
    private let signUpResultSubject = PublishSubject<Bool>()
    private let confirmPasswordSubject = PublishSubject<Bool>()
    private let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    private let disposeBag = DisposeBag()
    
    init(signUpInteractor: SignUpInteractor) {
        self.signUpInteractor = signUpInteractor
        self.setupObservable()
    }
    
    func signUp() {
        if password.value != passwordConfirm.value {
            confirmPasswordSubject.onNext(false)
            return
        }
        
        signUpInteractor
            .signUp(username: username.value, password: password.value)
            .observeOn(scheduler)
            .subscribe (onNext: { [weak self] result in
                guard let `self` = self else { return }
                
                switch result {
                case .success(_):
                    self.signUpResultSubject.onNext(true)
                case .failed(_):
                    self.signUpResultSubject.onNext(false)
                default:
                    self.signUpResultSubject.onNext(false)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupObservable() {
        Observable.combineLatest(
            username.asObservable(),
            password.asObservable(),
            passwordConfirm.asObservable()
            )
            .observeOn(scheduler)
            .skip(1)
            .subscribe (onNext: { [weak self] username, password, passwordConfirm in
                guard let `self` = self else { return }
                
                if username == ""
                    || password == ""
                    || passwordConfirm == "" {
                    self.signUpButtonEnable.accept(false)
                } else {
                    self.signUpButtonEnable.accept(true)
                }
            })
            .disposed(by: disposeBag)
    }
    
}
