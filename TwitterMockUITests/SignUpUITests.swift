//
//  SignUpUITests.swift
//  SignUpUITests
//
//  Created by Tracy Wu on 2019-04-01.
//  Copyright © 2019 TW. All rights reserved.
//

import XCTest
@testable import TwitterMock

class SignUpUITests: XCTestCase {
    
    private let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }
    
    func testPasswordConfirm() {
        if !app.buttons["Sign up"].exists {
            app.buttons["Log out"].tap()
        }
        
        let signUp = app.buttons["Sign up"]
        let exists = NSPredicate(format: "exists == 1")
        
        expectation(for: exists, evaluatedWith: signUp, handler: nil)
        waitForExpectations(timeout: 2, handler: nil)
        
        signUp.tap()
        
        let username = app.textFields["Username"]
        XCTAssertTrue(username.exists)
        
        let password1 = app.secureTextFields.matching(identifier: "Password").element(boundBy: 0)
        XCTAssertTrue(password1.exists)
        
        let password2 = app.secureTextFields.matching(identifier: "Password").element(boundBy: 1)
        XCTAssertTrue(password2.exists)
        
        username.tap()
        username.typeText("test")
        
        password1.tap()
        password1.typeText("1")
        
        password2.tap()
        password2.typeText("2")
        
        app.buttons["SIGN UP"].tap()
        
        XCTAssertTrue(app.alerts.buttons["OK"].exists)
        app.alerts.buttons["OK"].tap()
        
    }
}
