//
//  SwinjectStoryboard+Setup.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    class func setup() {
        
        // Debug only
        // disableLogging()
        
        registerViewInjections()
        registerViewModels()
        registerServices()
        registerAdapters()
        registerInteractors()
        registerRepositories()
    }
    
    private static func registerViewInjections() {
        defaultContainer.storyboardInitCompleted(SignInViewController.self) { r, c in
            c.viewModel = r.resolve(SignInViewModel.self)
        }
        
        defaultContainer.storyboardInitCompleted(SignUpViewController.self) { r, c in
            c.viewModel = r.resolve(SignUpViewModel.self)
        }
        
        defaultContainer.storyboardInitCompleted(FeedsCollectionViewController.self) { r, c in
            c.viewModel = r.resolve(FeedsCollectionViewModel.self)
        }
        
        defaultContainer.storyboardInitCompleted(FeedPublishViewController.self) { r, c in
            c.viewModel = r.resolve(FeedPublishViewModel.self)
        }
    }
    
    private static func registerViewModels() {
        defaultContainer.register(SignInViewModel.self) { r in
            return SignInViewModel(signInInteractor: r.resolve(SignInInteractor.self)!)
        }
        
        defaultContainer.register(SignUpViewModel.self) { r in
            return SignUpViewModel(signUpInteractor: r.resolve(SignUpInteractor.self)!)
        }
        
        defaultContainer.register(FeedsCollectionViewModel.self) { r in
            return FeedsCollectionViewModel(
                feedRepository: r.resolve(FeedRepository.self)!,
                userRepository: r.resolve(UserRepository.self)!,
                logoutInteractor: r.resolve(LogoutInteractor.self)!,
                feedRefreshInteractor: r.resolve(FeedRefreshInteractor.self)!)
        }
        
        defaultContainer.register(FeedPublishViewModel.self) { r in
            return FeedPublishViewModel(feedPublishInteractor: r.resolve(FeedPublishInteractor.self)!)
        }
    }
    
    private static func registerServices() {
        defaultContainer.register(MockServerService.self) { r in
            return MockServerServiceImpl(
                tokenService: r.resolve(MockTokenService.self)!,
                userRepository: r.resolve(UserRepository.self)!,
                feedRepository: r.resolve(FeedRepository.self)!)
            }
            .inObjectScope(.container)
        
        defaultContainer.register(MockTokenService.self) { r in
            return MockTokenServiceImpl()
        }
        
    }
    
    private static func registerAdapters() {
        defaultContainer.register(RealmStorageSetup.self) { r in
            return RealmStorageSetupImpl(keyChainRepository: r.resolve(KeyChainRepository.self)!)
        }
        
        defaultContainer.register(SetupManager.self) { r in
            return SetupManagerImpl(
                mockServerService: r.resolve(MockServerService.self)!,
                feedRepository: r.resolve(FeedRepository.self)!,
                userRepository: r.resolve(UserRepository.self)!)
        }
        
    }
    
    private static func registerInteractors() {
        defaultContainer.register(SignUpInteractor.self) { r in
            return SignUpInteractorImpl(
                serverService: r.resolve(MockServerService.self)!,
                userRepository: r.resolve(UserRepository.self)!)
        }
        
        defaultContainer.register(SignInInteractor.self) { r in
            return SignInInteractorImpl(
                serverService: r.resolve(MockServerService.self)!,
                setupManager: r.resolve(SetupManager.self)!,
                feedRefreshInteractor: r.resolve(FeedRefreshInteractor.self)!)
        }
        
        defaultContainer.register(FeedPublishInteractor.self) { r in
            return FeedPublishInteractorImpl(
                serverService: r.resolve(MockServerService.self)!,
                feedRepository: r.resolve(FeedRepository.self)!)
        }
        
        defaultContainer.register(LogoutInteractor.self) { r in
            return LogoutInteractorImpl(
                serverService: r.resolve(MockServerService.self)!,
                setupManager: r.resolve(SetupManager.self)!)
        }
        
        defaultContainer.register(FeedRefreshInteractor.self) { r in
            return FeedRefreshInteractorImpl(
                serverService: r.resolve(MockServerService.self)!,
                feedRepository: r.resolve(FeedRepository.self)!)
        }
    }
    
    private static func registerRepositories() {
        defaultContainer.register(KeyChainRepository.self) { r in
            return KeyChainRepositoryImpl(service: nil)
        }
        
        defaultContainer.register(UserRepository.self) { r in
            return RealmUserRepositoryImpl(inMemoryIdentifier: nil)
        }
        
        defaultContainer.register(FeedRepository.self) { r in
            return RealmFeedRepositoryImpl(inMemoryIdentifier: nil)
        }
        
        defaultContainer.register(UserRepository.self) { r in
            return RealmUserRepositoryImpl(inMemoryIdentifier: nil)
        }
    }
    
    private static func disableLogging() {
        Container.loggingFunction = nil
    }
    
}
