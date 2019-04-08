//
//  FeedCollectionViewCellViewModelTest.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

import XCTest
import RxSwift
@testable import TwitterMock

class FeedCollectionViewCellViewModelTest: XCTestCase {
    
    private var sut: FeedCollectionViewCellViewModel!
    private var disposeBag = DisposeBag()
    
    private let feed = FeedRM.sample().toFeed()
    private let user = UserRM.sample().toUser()
    
    override func setUp() {
        super.setUp()
        
        sut = FeedCollectionViewCellViewModel(feed: feed, user: user)
    }
    
    override func tearDown() {
        disposeBag = DisposeBag()
        super.tearDown()
    }
    
    func testUsername() {
        let expect = expectation(description: #function)
        sut.username
            .subscribe(onNext: { [unowned self] name in
                XCTAssertEqual(name, self.user.username!)
                expect.fulfill()
            })
            .disposed(by: disposeBag)
        
        wait(for: [expect], timeout: 1)
    }
    
}
