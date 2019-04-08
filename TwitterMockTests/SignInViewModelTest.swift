//
//  SignInViewModelTest.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

import XCTest
import RxSwift
@testable import TwitterMock

class SignInViewModelTest: XCTestCase {
    
    private var sut: SignInViewModel!
    private var disposeBag = DisposeBag()
    
    private let signInInteractor = SignInInteractorMock()
    private let setupManager = SetupManagerMock()
    
    override func setUp() {
        super.setUp()
        
        sut = SignInViewModel(signInInteractor: signInInteractor)
    }
    
    override func tearDown() {
        disposeBag = DisposeBag()
        super.tearDown()
    }
    
    func testSignIn() {
        let expect = expectation(description: #function)
        sut.signInResult
            .subscribe(onNext: { _ in
                expect.fulfill()
            })
            .disposed(by: disposeBag)
        
        sut.signIn()
        wait(for: [expect], timeout: 1)
    }
    
}
