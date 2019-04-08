//
//  UIButton+Rx.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-01.
//  Copyright © 2019 TW. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIButton {
    
    public var valid: Binder<Bool> {
        return Binder(self.base) { button, valid in
            button.isEnabled = valid
            button.backgroundColor = valid ? UIColor(red: 0, green: 118/255, blue: 255/255, alpha: 1.0) : .lightGray
        }
    }
    
}
