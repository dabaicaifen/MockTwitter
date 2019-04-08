//
//  Feed.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

struct Feed: Codable {
    var id: Int = 0
    var user: User?
    var message: String?
    var createdTime: String?
    var imageUrl: String?
    var width: Int = 0
    var height: Int = 0
    
    private enum CodingKeys: String, CodingKey {
        case id
        case user
        case message
        case createdTime
        case imageUrl
        case width
        case height
    }
}

typealias Feeds = [Feed]
