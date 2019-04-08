//
//  MockTokenService.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

protocol MockTokenService: class {
    /*
     * In real world, server will generate token.
     * This method will only return username for MOCK purpose
     */
    func getToken(username: String) -> String
}
