//
//  SignUpInteractorImplTest.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

import XCTest
import RxSwift
@testable import TwitterMock

class SignUpInteractorImplTest: XCTestCase {
    
    private var sut: SignUpInteractorImpl!
    private var disposeBag = DisposeBag()
    
    private let serverService = MockServerServiceMock()
    private let userRepository = UserRepositoryMock()
    
    override func setUp() {
        super.setUp()
        
        sut = SignUpInteractorImpl(serverService: serverService,
                                   userRepository: userRepository)
    }
    
    override func tearDown() {
        disposeBag = DisposeBag()
        super.tearDown()
    }
    
    func testSignIn() {
        let expect = expectation(description: #function)
        sut.signUp(username: "name", password: "1")
            .subscribe(onNext: { _ in
                expect.fulfill()
            })
            .disposed(by: disposeBag)

        wait(for: [expect], timeout: 1)
    }
    
}
