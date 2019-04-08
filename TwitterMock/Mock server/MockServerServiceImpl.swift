//
//  MockServerServiceImpl.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON
import SDWebImage

final class MockServerServiceImpl: MockServerService {
    
    var tokenService: MockTokenService!
    var userRepository: UserRepository!
    var feedRepository: FeedRepository!
    
    private let directory = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true).first ?? ""
    private let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
    private let disposeBag = DisposeBag()
    
    init(tokenService: MockTokenService,
         userRepository: UserRepository,
         feedRepository: FeedRepository) {
        self.tokenService = tokenService
        self.userRepository = userRepository
        self.feedRepository = feedRepository
    }
    
    func signUp(username: String, password: String) -> Observable<MockResult> {
        return Observable.create({ [weak self] observer in
            guard let `self` = self else { return Disposables.create() }
            
            var users = self.loadUsersFromFile() ?? []
            let user = User(id: users.count + 1,
                            username: username,
                            password: password,
                            avatarUrl: "")
            users += [user]
            self.saveUsersToFile(users)
            let data = try! JSONEncoder().encode(user)
            observer.onNext(.success(data: data))
            observer.onCompleted()
            return Disposables.create()
        })
            .subscribeOn(scheduler)
    }
    
    func signIn(username: String, password: String) -> Observable<MockResult> {
        return Observable.create({ [weak self] observer in
            guard let `self` = self else {
                observer.onNext(.failed(reason: "User does not exist"))
                observer.onCompleted()
                return Disposables.create()
            }
            
            guard let users = self.loadUsersFromFile() else {
                observer.onNext(.failed(reason: "User does not exist"))
                observer.onCompleted()
                return Disposables.create()
            }
            
            for user in users {
                if user.username == username && user.password == password {
                    let token = self.tokenService.getToken(username: username)
                    let json = ["id": user.id, "token": token] as [String : Any]
                    let data = try! JSONSerialization.data(withJSONObject: json, options: [])
                    DataCenter.shared.setCurrent(user: user)
                    observer.onNext(.success(data: data))
                    observer.onCompleted()
                }
            }
            
            observer.onNext(.failed(reason: "User does not exist"))
            observer.onCompleted()
            return Disposables.create()
        })
            .subscribeOn(scheduler)
    }
    
    func getFeeds(since: Int? = nil) -> Observable<MockResult> {
        return Observable.create({ [weak self] observer in
            guard let `self` = self else { return Disposables.create() }
            
            let sinceId = since ?? self.feedRepository.getCount()
            guard let feeds = self.requestFeeds(since: sinceId) else {
                return Disposables.create()
            }
            
            let data = try! JSONEncoder().encode(feeds)
            observer.onNext(.success(data: data))
            observer.onCompleted()
            return Disposables.create()
        })
            .subscribeOn(scheduler)
    }
    
    func postFeed(_ data: Data) -> Observable<MockResult> {
        return Observable.create({ [weak self] observer in
            guard let `self` = self else { return Disposables.create() }
            
            do {
                let currentCount = self.feedRepository.getCount()
                let id = currentCount + 1
                let json = try JSON(data: data)
                let message = json["message"].string ?? ""
                let image = json["image"].string ?? ""
                
                var imageUrl: String? = nil
                var width = 0
                var height = 0
                
                if image != "" {
                    width = 150
                    height = 150
                    if let imageData = Data(base64Encoded: image) {
                        let url =  URL(fileURLWithPath: self.directory).appendingPathComponent("\(String(id)).png")
                        _ = try imageData.write(to: url)
                        imageUrl = url.absoluteString
                    }
                }
                
                let feed = Feed(id: id,
                                user: DataCenter.shared.currentUser!,
                                message: message,
                                createdTime: Date().description,
                                imageUrl: imageUrl,
                                width: width,
                                height: height)
                
                let oldFeeds = self.loadFeedsFromFile() ?? []
                var newFeeds = [Feed]()
                for feed in oldFeeds {
                    if feed.id > currentCount {
                        let newFeed = Feed(id: feed.id + 1,
                                           user: feed.user,
                                           message: feed.message,
                                           createdTime: feed.createdTime,
                                           imageUrl: feed.imageUrl,
                                           width: feed.width,
                                           height: feed.height)
                        newFeeds += [newFeed]
                    } else {
                        newFeeds += [feed]
                    }
                }
                newFeeds += [feed]
                self.saveFeedsToFile(newFeeds)
                let data = try JSONEncoder().encode(feed)
                observer.onNext(.success(data: data))
                observer.onCompleted()
            }
            catch {
                observer.onNext(.failed(reason: error.localizedDescription))
                observer.onCompleted()
            }
            return Disposables.create()
        })
            .subscribeOn(scheduler)
    }
}

extension MockServerServiceImpl {
    
    var usersPath: URL {
        return URL(fileURLWithPath: directory).appendingPathComponent("mockUsers.txt")
    }
    
    var feedsPath: URL {
        return URL(fileURLWithPath: directory).appendingPathComponent("mock.txt")
    }
    
    private func requestFeeds(since id: Int) -> Feeds? {
        let feeds = loadFeedsFromFile()
        return feeds?.filter { $0.id > id && $0.id < id + 3}
    }
    
    private func loadFeedsFromFile() -> Feeds? {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: feedsPath.path) {
            try! fileManager.copyItem(at: Bundle.main.url(forResource: "mock", withExtension: "txt")!,
                                      to: feedsPath)
        }
        
        do {
            let data = try Data(contentsOf: feedsPath)
            return try JSONDecoder().decode(Feeds.self, from: data)
        }
        catch {
            print("[Server] Error load feeds: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func loadUsersFromFile() -> Users? {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: usersPath.path) {
            try! fileManager.copyItem(at: Bundle.main.url(forResource: "mockUsers", withExtension: "txt")!,
                                      to: usersPath)
        }
        
        do {
            let data = try Data(contentsOf: usersPath)
            return try JSONDecoder().decode(Users.self, from: data)
            
        }
        catch {
            print("[Server] Error load users: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func saveUsersToFile(_ users: Users) {
        do {
            let jsonData = try JSONEncoder().encode(users)
            let jsonString = String(data: jsonData, encoding: .utf8) ?? ""
            try jsonString.write(to: usersPath, atomically: false, encoding: .utf8)
        }
        catch {
            print("[Server] Error save users: \(error.localizedDescription)")
        }
    }
    
    private func saveFeedsToFile(_ feeds: Feeds) {
        do {
            let jsonData = try JSONEncoder().encode(feeds)
            let jsonString = String(data: jsonData, encoding: .utf8) ?? ""
            try jsonString.write(to: feedsPath, atomically: false, encoding: .utf8)
        }
        catch {
            print("[Server] Error save feeds: \(error.localizedDescription)")
        }
    }
    
}
