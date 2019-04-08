//
//  AppDelegate.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-01.
//  Copyright © 2019 TW. All rights reserved.
//

import UIKit
import  SwinjectStoryboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        resolveApi(RealmStorageSetup.self)!.setup(inMemoryIdentifier: nil)
        resolveApi(SetupManager.self)!.startMainUI()
        RxImagePickerDelegateProxy.registerImagePicker()
        return true
    }
    
    private func resolveApi<Api>(_ apiType: Api.Type) -> Api? {
        return SwinjectStoryboard.defaultContainer.resolve(apiType)
    }
}
