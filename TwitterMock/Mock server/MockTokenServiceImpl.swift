//
//  MockTokenServiceImpl.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

final class MockTokenServiceImpl: MockTokenService {
    
    func getToken(username: String) -> String {
        return username
    }
}
