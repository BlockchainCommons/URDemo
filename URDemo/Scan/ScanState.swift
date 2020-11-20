//
//  ScanState.swift
//  URDemo
//
//  Created by Wolf McNally on 7/8/20.
//  Copyright © 2020 Arciem LLC. All rights reserved.
//

import SwiftUI
import URKit
import Combine

public typealias CodesPublisher = PassthroughSubject<Set<String>, Error>

final class ScanState: ObservableObject {
    private var urDecoder: URDecoder!
    @Published var result: Result<UR, Error>?
    @Published var fragmentViews: [AnyView]!
    @Published var estimatedPercentComplete: Double!
    let codesPublisher = CodesPublisher()
    var bag = Set<AnyCancellable>()
    var startDate: Date?

    var elapsedTime: TimeInterval {
        guard let startDate = startDate else { return 0 }
        return Date.timeIntervalSinceReferenceDate - startDate.timeIntervalSinceReferenceDate
    }

    init() {
        codesPublisher
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.result = .failure(error)
                case .finished:
                    break
                }
            } receiveValue: { codes in
                self.receiveCodes(codes)
            }
            .store(in: &bag)

        restart()
    }

    func restart() {
        urDecoder = URDecoder()
        result = nil
        fragmentViews = [AnyView(Color.blue)]
        estimatedPercentComplete = 0
        startDate = nil
    }

    func receiveCodes(_ parts: Set<String>) {
        // Stop if we're already done with the decode.
        guard urDecoder.result == nil else { return }

        // Pass the parts we received to the decoder and make
        // a list of the ones it accepted.
        let acceptedParts = parts.filter { part in
            urDecoder.receivePart(part)
        }

        // Stop if the decoder didn't accept any parts.
        guard !acceptedParts.isEmpty else {
            beepError.play()
            return
        }

        result = urDecoder.result
        syncToResult()
    }

    private func syncToResult() {
        switch result {
        case .success?:
            fragmentViews = [AnyView(Color.white)]
            estimatedPercentComplete = 1
            beep4.play()
        case .failure(let error)?:
            beepError.play()
            print("🛑 \(error)")
        case nil:
            click.play()
            if startDate == nil {
                startDate = Date()
            }
            estimatedPercentComplete = urDecoder.estimatedPercentComplete
            fragmentViews = (0 ..< urDecoder.expectedPartCount).map { i in
                if urDecoder.receivedPartIndexes.contains(i) {
                    return AnyView(Color.white)
                } else {
                    return urDecoder.lastPartIndexes.contains(i) ? AnyView(Color.blue.brightness(0.2)) : AnyView(Color.blue)
                }
            }
        }
    }
}
