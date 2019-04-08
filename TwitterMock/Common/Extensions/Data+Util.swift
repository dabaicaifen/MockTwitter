//
//  Data+Util.swift
//  TwitterMock
//
//  Created by Tracy Wu on 2019-04-04.
//  Copyright © 2019 TW. All rights reserved.
//

import Foundation

extension Data {
    
    func hexEncodedString() -> String {
        let hexAlphabet = "0123456789abcdef".unicodeScalars.map { $0 }
        
        return String(self.reduce(into: "".unicodeScalars, { (result, value) in
            result.append(hexAlphabet[Int(value/16)])
            result.append(hexAlphabet[Int(value%16)])
        }))
    }
}
