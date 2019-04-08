//
//  FeedPublishInteractorImplTest.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

import XCTest
import RxSwift
@testable import TwitterMock

class FeedPublishInteractorImplTest: XCTestCase {
    
    private var sut: FeedPublishInteractorImpl!
    private var disposeBag = DisposeBag()
    
    private let serverService = MockServerServiceMock()
    private let feedRepository = FeedRepositoryMock()
    
    override func setUp() {
        super.setUp()
        
        sut = FeedPublishInteractorImpl(serverService: serverService,
                                        feedRepository: feedRepository)
    }
    
    override func tearDown() {
        disposeBag = DisposeBag()
        super.tearDown()
    }
    
    func testPostFeed() {
        let expect = expectation(description: #function)
        sut.postFeed(message: "message", image: "")
            .subscribe(onNext: { _ in
                expect.fulfill()
            })
            .disposed(by: disposeBag)
        
        wait(for: [expect], timeout: 1)
    }
}
