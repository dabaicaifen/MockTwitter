//
//  RealmSetupError.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

struct RealmSetupError: LocalizedError {

    var localizedDescription: String {
        return message
    }
    
    var errorDescription: String? {
        return message
    }
    
    private let message: String
    
    init(message: String) {
        self.message = message
    }
}
