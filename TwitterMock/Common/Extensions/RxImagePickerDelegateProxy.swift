//
//  RxImagePickerDelegateProxy.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-03.
//  Copyright © 2019 TW. All rights reserved.
//

import UIKit
import RxCocoa

open class RxImagePickerDelegateProxy: RxNavigationControllerDelegateProxy, UIImagePickerControllerDelegate {
    
    public init(imagePicker: UIImagePickerController) {
        super.init(navigationController: imagePicker)
    }
    
    static func registerImagePicker() {
        RxImagePickerDelegateProxy.register { RxImagePickerDelegateProxy(imagePicker: $0) }
    }
}
