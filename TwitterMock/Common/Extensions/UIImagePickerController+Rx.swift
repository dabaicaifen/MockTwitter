//
//  UIImagePickerController+Rx.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-03.
//  Copyright © 2019 TW. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIImagePickerController {
    
    public var didFinishPickingMediaWithInfo: Observable<[String : Any]> {
        return delegate
            .methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerController(_:didFinishPickingMediaWithInfo:)))
            .map({ (a) in
                return try castOrThrow(Dictionary<String, Any>.self, a[1])
            })
    }
    
    public var didCancel: Observable<()> {
        return delegate
            .methodInvoked(#selector(UIImagePickerControllerDelegate.imagePickerControllerDidCancel(_:)))
            .map {_ in () }
    }
    
}

fileprivate func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }
    return returnValue
}
