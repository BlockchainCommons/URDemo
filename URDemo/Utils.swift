//
//  Utils.swift
//  URDemo
//
//  Created by Wolf McNally on 7/6/20.
//  Copyright © 2020 Arciem LLC. All rights reserved.
//

import Foundation
import URKit

extension String {
    var utf8: Data {
        return data(using: .utf8)!
    }
}

extension Data {
    static func random(_ len: Int) -> Data {
        let values = (0 ..< len).map { _ in UInt8.random(in: 0 ... 255) }
        return Data(values)
    }

    var utf8: String {
        String(data: self, encoding: .utf8)!
    }

    var bytes: [UInt8] {
        var b: [UInt8] = []
        b.append(contentsOf: self)
        return b
    }
}

extension Array where Element == UInt8 {
    var data: Data {
        Data(self)
    }
}

func makeBytesUR(_ data: Data) -> UR {
    let cbor = CBOR.byteString(data.bytes).encode().data
    return try! UR(type: "bytes", cbor: cbor)
}
