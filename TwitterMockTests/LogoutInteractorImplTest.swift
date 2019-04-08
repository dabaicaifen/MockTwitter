//
//  LogoutInteractorImplTest.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

import XCTest
import RxSwift
@testable import TwitterMock

class LogoutInteractorImplTest: XCTestCase {
    
    private var sut: LogoutInteractorImpl!
    private var disposeBag = DisposeBag()
    
    private let serverService = MockServerServiceMock()
    private let setupManager = SetupManagerMock()
    override func setUp() {
        super.setUp()
        
        sut = LogoutInteractorImpl(serverService: serverService, setupManager: setupManager)
    }
    
    override func tearDown() {
        disposeBag = DisposeBag()
        super.tearDown()
    }
    
    func testLogout() {
        let expect = expectation(description: #function)
        sut.logout()
            .subscribe(onNext: { [unowned self] name in
                XCTAssertTrue(self.setupManager.tokenIsCleared)
                expect.fulfill()
            })
            .disposed(by: disposeBag)
        
        wait(for: [expect], timeout: 1)
    }
    
}
