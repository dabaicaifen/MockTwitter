//
//  RealmFeedRepositoryImpl.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RealmSwift
import RxRealm
import RxSwift

final class RealmFeedRepositoryImpl: FeedRepository {
    
    var isEmpty: Bool {
        return FeedRMDAO().isEmpty
    }
    
    var changes: Observable<FeedChanges> {
        return getChanges()
    }
    
    private var feedRMDAO: FeedRMDAO {
        return FeedRMDAO(inMemoryIdentifier: inMemoryIdentifier)
    }
    
    private var feedRMAssociation: FeedRMAssociation {
        return FeedRMAssociation(inMemoryIdentifier: inMemoryIdentifier)
    }
    
    private let inMemoryIdentifier: String?

    init(inMemoryIdentifier: String? = nil) {
        self.inMemoryIdentifier = inMemoryIdentifier
    }
    
    func getCount() -> Int {
        return feedRMDAO.count
    }
    
    func save(_ feed: Feed) {
        let feedRM = FeedRM.create(from: feed)
        feedRMDAO.save(model: feedRM)
        feedRMAssociation.update(for: feedRM)
    }
    
    func save(_ feeds: Feeds) {
        feeds.forEach { save($0) }
    }
    
    private func getChanges() -> Observable<FeedChanges> {
        return Observable.changeset(from: getAllSorted())
            .map { result, changeset in
                return FeedChanges(items: result.map { $0.toFeed() },
                                   changeset: changeset?.toEntityChangeset())
        }
    }
    
    private func getAllSorted() -> Results<FeedRM> {
        return feedRMDAO.all().sorted(byKeyPath: "id", ascending: false)
    }
    
}
