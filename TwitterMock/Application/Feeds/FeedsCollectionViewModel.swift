//
//  FeedsCollectionViewModel.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class FeedsCollectionViewModel {
    
    var itemsCount: Int {
        return items.value.count
    }
    
    let changeset = BehaviorRelay(value: Changeset.empty())
    
    private let items = BehaviorRelay(value: [FeedCollectionViewCellViewModel]())
    private let feedRepository: FeedRepository!
    private let userRepository: UserRepository!
    private let logoutInteractor: LogoutInteractor!
    private let feedRefreshInteractor: FeedRefreshInteractor!
    private let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    private let disposeBag = DisposeBag()
    
    init(feedRepository: FeedRepository,
         userRepository: UserRepository,
         logoutInteractor: LogoutInteractor,
         feedRefreshInteractor: FeedRefreshInteractor) {
        self.feedRepository = feedRepository
        self.userRepository = userRepository
        self.logoutInteractor = logoutInteractor
        self.feedRefreshInteractor = feedRefreshInteractor
    }
    
    func item(at index: Int) -> FeedCollectionViewCellViewModel? {
        guard index < itemsCount else { return nil }
        return items.value[index]
    }
    
    func didLoad() {
        observeChanges()
    }
    
    func refreshFeeds() {
        feedRefreshInteractor.refreshFeeds(since: nil)
    }
    
    func logout() {
        logoutInteractor.logout()
            .observeOn(scheduler)
            .subscribe(onNext: { _ in
                ScreenManager.shared.displaySignInScreen()
            })
            .disposed(by: disposeBag)
    }

    private func observeChanges() {
        feedRepository.changes
            .observeOn(scheduler)
            .subscribe(onNext: { [weak self] changes in
                self?.emit(changes: changes)
            })
            .disposed(by: disposeBag)
    }
    
    private func emit(changes: FeedChanges) {
        items.accept(changes.items.map {
            FeedCollectionViewCellViewModel(feed: $0, user: $0.user ?? User.empty())
        })
        changeset.accept(changes.changeset ?? Changeset.empty())
    }
    
}
