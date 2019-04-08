//
//  SignInInteractorImplTest.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

import XCTest
import RxSwift
@testable import TwitterMock

class SignInInteractorImplTest: XCTestCase {
    
    private var sut: SignInInteractorImpl!
    private var disposeBag = DisposeBag()
    
    private let serverService = MockServerServiceMock()
    private let setupManager = SetupManagerMock()
    private let feedRefreshInteractor = FeedRefreshInteractorMock()
    override func setUp() {
        super.setUp()
        
        sut = SignInInteractorImpl(serverService: serverService,
                                   setupManager: setupManager,
                                   feedRefreshInteractor: feedRefreshInteractor)
    }
    
    override func tearDown() {
        disposeBag = DisposeBag()
        super.tearDown()
    }
    
    func testSignIn() {
        let expect = expectation(description: #function)
        sut.signIn(username: "name", password: "7")
            .subscribe(onNext: { _ in
                expect.fulfill()
            })
            .disposed(by: disposeBag)
        
        wait(for: [expect], timeout: 1)
    }
    
}
