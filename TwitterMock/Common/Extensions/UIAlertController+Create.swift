//
//  UIAlertController+Create.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-05.
//  Copyright © 2019 TW. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func simple(title: String?,
                       message: String?,
                       actions: [UIAlertAction]? = nil) -> UIAlertController {
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        let actionList = actions == nil ? [cancelAction] : actions
        
        let alert = UIAlertController(title: title ?? "",
                                      message: message ?? "",
                                      preferredStyle: .alert)
        
        for action: UIAlertAction in actionList! {
            alert.addAction(action)
        }
        return alert
    }
}
