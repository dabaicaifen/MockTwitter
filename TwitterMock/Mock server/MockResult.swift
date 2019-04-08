//
//  MockResult.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-01.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

enum MockResult {
    case unknown
    case success(data: Data)
    case failed(reason: String)
}
