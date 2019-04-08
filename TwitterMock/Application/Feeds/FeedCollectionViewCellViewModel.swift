//
//  FeedCollectionViewCellViewModel.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RxSwift

final class FeedCollectionViewCellViewModel {
    
    var username: Observable<String> {
        return getUserName()
    }
    
    var createdTime: Observable<String> {
        return getCreatedTime()
    }
    
    var message: Observable<String> {
        return getMessage()
    }
    
    var avatarUrl: URL? {
        return getAvatarUrl()
    }
    
    var imageUrl: URL? {
        return getImageUrl()
    }
    
    var imageHidden: Observable<Bool> {
        return getImageHidden()
    }
    
    var cellSize: CGSize {
        return CGSize(width: cellWidth, height: getCellHeight())
    }
    
    private let cellWidth = UIScreen.main.bounds.size.width - 40
    
    private let feed: Feed
    private let user: User
    
    init(feed: Feed, user: User) {
        self.feed = feed
        self.user = user
    }
    
    private func getCellHeight() -> CGFloat {
        var height = CGFloat(80)
        if feed.message != nil {
            height += feed.message!.height(width: cellWidth, font: .systemFont(ofSize: 17))
        }
        if feed.width > 0 {
            height += CGFloat(feed.height) * cellWidth / CGFloat(feed.width)
        }
        return height
    }
    
    private func getUserName() -> Observable<String> {
        return .just(user.username ?? "")
    }
    
    private func getCreatedTime() -> Observable<String> {
        return .just(feed.createdTime ?? "")
    }
    
    private func getMessage() -> Observable<String> {
        return .just(feed.message ?? "")
    }
    
    private func getAvatarUrl() -> URL? {
        return getUrl(user.avatarUrl ?? "")
    }
    
    private func getImageUrl() -> URL? {
        return getUrl(feed.imageUrl ?? "")
    }
    
    private func getImageHidden() -> Observable<Bool> {
        return .just(feed.height == 0)
    }
    
    private func getUrl(_ urlString: String) -> URL? {
        guard urlString != "" else { return nil }
        return URL(string: urlString)
    }
}
