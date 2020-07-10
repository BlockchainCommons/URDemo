//
//  ScannerSession.swift
//  URDemo
//
//  Created by Wolf McNally on 7/8/20.
//  Copyright © 2020 Arciem LLC. All rights reserved.
//

import SwiftUI
import URKit

class ScannerSession: ObservableObject {
    private var decoder: URDecoder!
    @Published var result: Result<UR, Error>?
    @Published var fragmentViews: [AnyView]!
    @Published var estimatedPercentComplete: Double!
    var startDate: Date?

    var elapsedTime: TimeInterval {
        guard let startDate = startDate else { return 0 }
        return Date.timeIntervalSinceReferenceDate - startDate.timeIntervalSinceReferenceDate
    }

    init() {
        restart()
    }

    func restart() {
        decoder = URDecoder()
        result = nil
        fragmentViews = [AnyView(Color.blue)]
        estimatedPercentComplete = 0
        startDate = nil
    }

    func receiveParts(_ parts: Set<String>) {
        // Stop if we're already done with the decode.
        guard decoder.result == nil else { return }

        // Pass the parts we received to the decoder and make
        // a list of the ones it accepted.
        let acceptedParts = parts.filter { part in
            decoder.receivePart(part)
        }

        // Stop if the decoder didn't accept any parts.
        guard !acceptedParts.isEmpty else {
            beepError.play()
            return
        }

        result = decoder.result

        switch result {
        case .success?:
            beep4.play()
        case .failure(let error)?:
            beepError.play()
            print(error)
        case nil:
            click.play()
            if startDate == nil {
                startDate = Date()
            }
            estimatedPercentComplete = decoder.estimatedPercentComplete
            fragmentViews = (0 ..< decoder.expectedPartCount).map { i in
                if decoder.receivedPartIndexes.contains(i) {
                    return AnyView(Color.white)
                } else {
                    return decoder.lastPartIndexes.contains(i) ? AnyView(Color.blue.brightness(0.2)) : AnyView(Color.blue)
                }
            }
        }
    }
}
