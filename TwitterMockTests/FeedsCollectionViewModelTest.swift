//
//  FeedsCollectionViewModelTest.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

import XCTest
import RxSwift
@testable import TwitterMock

class FeedsCollectionViewModelTest: XCTestCase {
    
    private var sut: FeedsCollectionViewModel!
    private var disposeBag = DisposeBag()
    
    private let feedRepository = FeedRepositoryMock()
    private let userRepository = UserRepositoryMock()
    private let logoutInteractor = LogoutInteractorMock()
    private let feedRefreshInteractor = FeedRefreshInteractorMock()
    
    override func setUp() {
        super.setUp()
        
        sut = FeedsCollectionViewModel(feedRepository: feedRepository,
                                       userRepository: userRepository,
                                       logoutInteractor: logoutInteractor,
                                       feedRefreshInteractor: feedRefreshInteractor)
    }
    
    override func tearDown() {
        disposeBag = DisposeBag()
        super.tearDown()
    }
    
    func testDidLoad() {
        let expect = expectation(description: #function)
        sut.changeset
            .skip(1)
            .subscribe(onNext: { _ in
                expect.fulfill()
            })
            .disposed(by: disposeBag)
        
        sut.didLoad()
        wait(for: [expect], timeout: 1)
    }
    
}
