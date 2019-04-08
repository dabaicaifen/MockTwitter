//
//  SignUpViewModelTest.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

import XCTest
import RxSwift
@testable import TwitterMock

class SignUpViewModelTest: XCTestCase {
    
    private var sut: SignUpViewModel!
    private var disposeBag = DisposeBag()
    
    private let signUpInteractor = SignUpInteractorMock()
    
    override func setUp() {
        super.setUp()
        
        sut = SignUpViewModel(signUpInteractor: signUpInteractor)
    }
    
    override func tearDown() {
        disposeBag = DisposeBag()
        super.tearDown()
    }
    
    func testSignIn() {
        let expect = expectation(description: #function)
        sut.signUpResult
            .subscribe(onNext: { _ in
                expect.fulfill()
            })
            .disposed(by: disposeBag)
        
        sut.signUp()
        wait(for: [expect], timeout: 1)
    }
    
}
