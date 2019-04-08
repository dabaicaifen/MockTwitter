//
//  RealmChangeset+Util.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-03.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation
import RxRealm

extension RealmChangeset {
    
    func toEntityChangeset() -> Changeset {
        return Changeset(deletions: deleted,
                         insertions: inserted,
                         modifications: updated)
    }
}

