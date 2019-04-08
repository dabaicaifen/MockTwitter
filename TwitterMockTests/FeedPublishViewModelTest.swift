//
//  FeedPublishViewModelTest.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

import XCTest
import RxSwift
@testable import TwitterMock

class FeedPublishViewModelTest: XCTestCase {
    
    private var sut: FeedPublishViewModel!
    private var disposeBag = DisposeBag()
    
    private let feedPublishInteractor = FeedPublishInteractorMock()
    
    override func setUp() {
        super.setUp()
        
        sut = FeedPublishViewModel(feedPublishInteractor: FeedPublishInteractorMock())
    }
    
    override func tearDown() {
        disposeBag = DisposeBag()
        super.tearDown()
    }
    
    func testPublishResult() {
        let expect = expectation(description: #function)
        sut.publishResult
            .subscribe(onNext: { _ in
                expect.fulfill()
            })
            .disposed(by: disposeBag)
        
        sut.publishFeed()
        wait(for: [expect], timeout: 1)
    }
    
}
