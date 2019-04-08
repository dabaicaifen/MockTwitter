//
//  FeedRM.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RealmSwift

final class FeedRM: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var user: UserRM?
    @objc dynamic var message: String?
    @objc dynamic var createdTime: String?
    @objc dynamic var imageUrl: String?
    @objc dynamic var width: Int = 0
    @objc dynamic var height: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func create(from feed: Feed) -> FeedRM {
        let feedRM = FeedRM()
        feedRM.id = feed.id
        feed.user.map { feedRM.user = UserRM.create(from: $0)}
        feed.message.map { feedRM.message = $0 }
        feed.createdTime.map { feedRM.createdTime = $0 }
        feed.imageUrl.map { feedRM.imageUrl = $0 }
        feedRM.width = feed.width
        feedRM.height = feed.height
        return feedRM
    }
    
    func toFeed() -> Feed {
        return Feed(id: id,
                    user: user?.toUser(),
                    message: message ?? "",
                    createdTime: createdTime,
                    imageUrl: imageUrl,
                    width: width,
                    height: height)
    }
}
