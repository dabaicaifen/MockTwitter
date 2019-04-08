//
//  FeedPublishInteractorImpl.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-03.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

final class FeedPublishInteractorImpl: FeedPublishInteractor {
    
    private let serverService: MockServerService!
    private let feedRepository: FeedRepository!
    
    init(serverService: MockServerService,
         feedRepository: FeedRepository) {
        self.serverService = serverService
        self.feedRepository = feedRepository
    }
    
    func postFeed(message: String, image: String) -> Observable<MockResult> {
        let json: JSON = ["message" : message, "image" : image]
        let data = try! json.rawData()
        return serverService.postFeed(data)
            .do(onNext: { [weak self] result in
                switch result {
                case .success(let data):
                    do {
                        let feed = try JSONDecoder().decode(Feed.self, from: data)
                        self?.feedRepository.save(feed)
                    }
                    catch {
                        print("JSONDecoder error")
                    }
                default: break
                }
            })
    }
    
}
