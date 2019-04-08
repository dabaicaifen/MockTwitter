//
//  FeedRMAssociation.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RealmSwift

final class FeedRMAssociation {
    
    private var feedRMDAO: FeedRMDAO {
        return FeedRMDAO(inMemoryIdentifier: inMemoryIdentifier)
    }
    
    private var userRMDAO: UserRMDAO {
        return UserRMDAO(inMemoryIdentifier: inMemoryIdentifier)
    }
    
    private let inMemoryIdentifier: String?
    
    init(inMemoryIdentifier: String? = nil) {
        self.inMemoryIdentifier = inMemoryIdentifier
    }
    
    func update(for feeds: [FeedRM]) {
        feeds.forEach { update(for: $0) }
    }
    
    func update(for feed: FeedRM) {
        updateUser(for: feed.makeCopy())
        feedRMDAO.save(model: feed)
    }
    
    private func updateUser(for feed: FeedRM) {
        guard let userRm = feed.user else { return }
        userRMDAO.save(model: userRm)
    }
    
}
