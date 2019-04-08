//
//  RealmStorageSetup.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-02.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

protocol RealmStorageSetup: class {
    func setup(inMemoryIdentifier: String?)
}
