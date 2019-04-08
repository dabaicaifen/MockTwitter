//
//  FeedPublishViewModel.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-03.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class FeedPublishViewModel {
    
    var username: Observable<String> {
        return getUserName()
    }
    
    var avatarUrl: URL? {
        return getAvatarUrl()
    }
    
    var publishResult: Observable<Bool> {
        return publishResultSubject
    }
    
    let sendBarButtonEnable = BehaviorRelay(value: false)
    let message = BehaviorRelay(value: "")
    let image = BehaviorRelay(value: "")
    
    private let feedPublishInteractor: FeedPublishInteractor!
    private let publishResultSubject = PublishSubject<Bool>()
    private let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    private let disposeBag = DisposeBag()
    
    init(feedPublishInteractor: FeedPublishInteractor) {
        self.feedPublishInteractor = feedPublishInteractor
        self.setupObservable()
    }
    
    func publishFeed() {
        feedPublishInteractor
            .postFeed(message: message.value, image: image.value)
            .observeOn(scheduler)
            .subscribe (onNext: { [weak self] result in
                switch result {
                case .success(_):
                    self?.publishResultSubject.onNext(true)
                case .failed(_):
                    self?.publishResultSubject.onNext(false)
                default:
                    self?.publishResultSubject.onNext(false)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupObservable() {
        Observable.combineLatest(
            message.asObservable(),
            image.asObservable())
            .observeOn(scheduler)
            .skip(1)
            .subscribe (onNext: { [weak self] message, image in
                if message == "" && image == "" {
                    self?.sendBarButtonEnable.accept(false)
                } else {
                    self?.sendBarButtonEnable.accept(true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func getUserName() -> Observable<String> {
        return .just(DataCenter.shared.currentUser?.username ?? "")
    }
    
    private func getAvatarUrl() -> URL? {
        return URL(fileURLWithPath: DataCenter.shared.currentUser?.avatarUrl ?? "")
    }
    
}
