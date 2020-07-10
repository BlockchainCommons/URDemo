//
//  Scenario.swift
//  URDemo
//
//  Created by Wolf McNally on 7/5/20.
//  Copyright © 2020 Arciem LLC. All rights reserved.
//

import Foundation
import URKit
import Combine
import SwiftUI
import LifeHash

struct Scenario: Identifiable {
    let id: UUID = UUID()
    let name: String
    let messageLen: Int
    let maxFragmentLen: Int
}

extension UREncoder {
    func nextQRPart() -> Data {
        nextPart().uppercased().utf8
    }
}

class RunningScenario: ObservableObject {
    let scenario: Scenario
    static let defaultInterval: TimeInterval = 1.0 / 10
    let name: String
    var encoder: UREncoder!
    var message: Data!
    @Published var ur: UR!
    let lifeHashState = LifeHashState()
    let maxFragmentLen: Int
    var isSinglePart: Bool { encoder.isSinglePart }
    var messageLen: Int { message.count }
    var seqNum: UInt32 { encoder.seqNum }
    var seqLen: Int { encoder.seqLen }
    var partIndexes: Set<Int> { encoder.partIndexes }
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    var timerCanceler: AnyCancellable?
    var lastSwitch: Date!
    var interval: TimeInterval = defaultInterval
    @Published var framesPerSecond: Double = 1 / defaultInterval {
        didSet { interval = 1 / framesPerSecond }
    }
    @Published var part: Data!
    @Published var fragmentViews: [AnyView] = [AnyView(EmptyView())]

    init(scenario: Scenario) {
        self.scenario = scenario
        name = scenario.name
        maxFragmentLen = scenario.maxFragmentLen
        restart()
    }

    func restart() {
        message = Data.random(scenario.messageLen)
        ur = makeBytesUR(message)
        lifeHashState.input = ur.cbor
        encoder = UREncoder(ur, maxFragmentLen: maxFragmentLen)
        lastSwitch = Date()
        self.nextPart()
    }

    func run() {
        guard !self.isSinglePart else { return }
        timerCanceler = timer.sink { [unowned self] date in
            guard date > self.lastSwitch + self.interval else { return }
            self.lastSwitch = date
            //click.play()
            self.nextPart()
        }
    }

    private func nextPart() {
        part = encoder.nextQRPart()
        fragmentViews = (0 ..< seqLen).map { i in
            encoder.partIndexes.contains(i) ? AnyView(Color.blue.brightness(0.2)) : AnyView(Color.blue)
        }
    }

    func stop() {
        timerCanceler?.cancel()
        timerCanceler = nil
    }

    func faster() {
        framesPerSecond = min(framesPerSecond + 1, 20)
    }

    func slower() {
        framesPerSecond = max(framesPerSecond - 1, 1.0)
    }
}
