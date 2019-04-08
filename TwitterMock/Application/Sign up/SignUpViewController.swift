//
//  SignUpViewController.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-01.
//  Copyright © 2019 TW. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    var viewModel: SignUpViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupObservable()
    }
    
    private func setupViewModel() {
        viewModel.signUpButtonEnable
            .observeOn(MainScheduler.asyncInstance)
            .bind(to: signUpButton.rx.valid)
            .disposed(by: disposeBag)
        
        viewModel.confirmPassword
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] same in
                if !same {
                    let alert = UIAlertController.simple(title: nil,
                                                         message: "Please confirm password")
                    self?.present(alert, animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.signUpResult
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] success in
                if !success {
                    let alert = UIAlertController.simple(title: nil,
                                                         message: "Sign up failed")
                    self?.present(alert, animated: true)
                } else {
                    ScreenManager.shared.displaySignInScreen()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupObservable() {
        usernameTextField
            .rx.text.orEmpty
            .skip(1)
            .bind(to: viewModel.username)
            .disposed(by: disposeBag)
        
        passwordTextField
            .rx.text.orEmpty
            .skip(1)
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        passwordConfirmTextField
            .rx.text.orEmpty
            .skip(1)
            .bind(to: viewModel.passwordConfirm)
            .disposed(by: disposeBag)
        
        signUpButton
            .rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.signUp()
            })
            .disposed(by: disposeBag)
    }
}
