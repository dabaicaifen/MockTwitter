//
//  FeedRefreshInteractorImpl.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-06.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RxSwift

final class FeedRefreshInteractorImpl: FeedRefreshInteractor {
    
    private let serverService: MockServerService!
    private let feedRepository: FeedRepository!
    private let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    private let disposeBag = DisposeBag()
    
    init(serverService: MockServerService,
         feedRepository: FeedRepository) {
        self.serverService = serverService
        self.feedRepository = feedRepository
    }
    
    func refreshFeeds(since id: Int?) {
        serverService.getFeeds(since: nil)
            .subscribeOn(scheduler)
            .subscribe(onNext: { [weak self] result in
                switch result {
                case .success(let data):
                    do {
                        let feeds = try JSONDecoder().decode(Feeds.self, from: data)
                        self?.feedRepository.save(feeds)
                    }
                    catch {
                        print("JSONDecoder error")
                    }
                case .failed(let reason):
                    print("[Server] error: \(reason)")
                default: break
                }
            })
            .disposed(by: disposeBag)
    }
}
