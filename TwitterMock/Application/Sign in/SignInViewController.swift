//
//  SignInViewController.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-01.
//  Copyright © 2019 TW. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyJSON

final class SignInViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    var viewModel: SignInViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupObservable()
    }
    
    private func setupViewModel() {
        viewModel.signInButtonEnable
            .observeOn(MainScheduler.asyncInstance)
            .bind(to: signInButton.rx.valid)
            .disposed(by: disposeBag)
        
        viewModel.signInResult
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] success in
                if !success {
                    let alert = UIAlertController.simple(title: nil,
                                                         message: "Sign in failed")
                    self?.present(alert, animated: true)
                } else {
                    ScreenManager.shared.displayFeedsScreen()
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
        
        signInButton
            .rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.signIn()
            })
            .disposed(by: disposeBag)
        
        forgotPasswordButton
            .rx.tap
            .subscribe(onNext: { [weak self] _ in
                let alert = UIAlertController.simple(title: "oops",
                                                     message: "I did not do it")
                self?.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
}
