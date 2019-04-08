//
//  Object+Util.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RealmSwift

extension Object {
    
    func makeCopy() -> Self {
        return type(of: self).init(value: self,
                                   schema: .partialPrivateShared())
    }
}
