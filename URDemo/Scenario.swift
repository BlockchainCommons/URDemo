//
//  Scenario.swift
//
//  Copyright © 2020 by Blockchain Commons, LLC
//  Licensed under the "BSD-2-Clause Plus Patent License"
//

import Foundation
import URKit

/// A scenario for displaying a (possibly animated) random UR.
struct Scenario: Identifiable {
    let id: UUID = UUID()
    let name: String
    let messageLen: Int
    let maxFragmentLen: Int

    func makeUR() -> UR {
        let message = Data.random(messageLen)
        return makeBytesUR(message)
    }
}

let scenarios = [
    Scenario(name: "300b, Single Part", messageLen: 300, maxFragmentLen: 500),
    Scenario(name: "800b, Single Part", messageLen: 800, maxFragmentLen: 1_000),
    Scenario(name: "300b, 100b Frags", messageLen: 300, maxFragmentLen: 100),
    Scenario(name: "1K, 250b Frags", messageLen: 1_024, maxFragmentLen: 250),
    Scenario(name: "10K, 100b Frags", messageLen: 10_000, maxFragmentLen: 100),
    Scenario(name: "10K, 250b Frags", messageLen: 10_000, maxFragmentLen: 250),
    Scenario(name: "10K, 500b Frags", messageLen: 10_000, maxFragmentLen: 500),
    Scenario(name: "10K, 700b Frags", messageLen: 10_000, maxFragmentLen: 700)
]
