//
//  ScreenManager.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-04.
//  Copyright © 2019 TW. All rights reserved.
//

import UIKit

final class ScreenManager {
    
    static let shared = ScreenManager()
    
    private(set) var navigationController: UINavigationController?
    
    func displayFeedsScreen() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.getRootNavigationController().setViewControllers([self.getFeesScreen()], animated: true)
        }
    }
    
    func displaySignInScreen() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.getRootNavigationController().setViewControllers([self.getSignInScreen()], animated: true)
        }
    }
    
    func displaySignUpScreen() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.getRootNavigationController().setViewControllers([self.getSignUpScreen()], animated: true)
        }
    }
    
    private func getFeesScreen() -> UIViewController {
        return getMainStoryboard().instantiateViewController(withIdentifier: "FeedsCollectionViewController")
    }
    
    private func getSignInScreen() -> UIViewController {
        return getMainStoryboard().instantiateViewController(withIdentifier: "SignInViewController")
    }
    
    private func getSignUpScreen() -> UIViewController {
        return getMainStoryboard().instantiateViewController(withIdentifier: "SignUpViewController")
    }
    
    private func getRootNavigationController() -> UINavigationController {
        let window = (UIApplication.shared.delegate as! AppDelegate).window!
        return window.rootViewController as! UINavigationController
    }
    
    private func getMainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    private init() {}
    
}
