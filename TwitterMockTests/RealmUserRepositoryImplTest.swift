//
//  RealmUserRepositoryImplTest.swift
//  TwitterMockTests
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

import XCTest
import RxSwift
@testable import TwitterMock

class RealmUserRepositoryImplTest: XCTestCase {
    
    private var sut: RealmUserRepositoryImpl!
    private var disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        
        sut = RealmUserRepositoryImpl(inMemoryIdentifier: String(describing: self))
    }
    
    override func tearDown() {
        disposeBag = DisposeBag()
        super.tearDown()
    }
    
    func testChanges() {
        let expect = expectation(description: #function)
        sut.changes
            .subscribe(onNext: { _ in
                expect.fulfill()
            })
            .disposed(by: disposeBag)
        
        wait(for: [expect], timeout: 1)
    }
    
}
