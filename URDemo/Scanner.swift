//
//  Scanner.swift
//
//  Copyright © 2020 by Blockchain Commons, LLC
//  Licensed under the "BSD-2-Clause Plus Patent License"
//

import SwiftUI
import URKit
import URUI

struct Scanner: View {
    @Binding var isPresenting: Bool
    @StateObject var scanState = URScanState()
    @State private var estimatedPercentComplete = 0.0
    @State private var fragmentStates = [URFragmentBar.FragmentState]()
    @State private var canRestart = true
    @State private var result: URScanResult?
    @State private var startDate: Date?
    
    private var elapsedTime: TimeInterval {
        guard let startDate = startDate else { return 0 }
        return Date.timeIntervalSinceReferenceDate - startDate.timeIntervalSinceReferenceDate
    }
    
    func restart() {
        result = nil
        startDate = nil
        estimatedPercentComplete = 0
        fragmentStates = [.off]
        scanState.restart()
    }

    var body: some View {
        VStack {
            ScanControls(isPresenting: _isPresenting, canRestart: $canRestart, restart: self.restart )
            Spacer()
            if let result = result {
                ScanCompleteView(result: result, elapsed: elapsedTime)
            } else {
                URVideo(scanState: scanState)
            }
            Spacer()
            VStack {
                URFragmentBar(states: $fragmentStates)
                URProgressBar(value: $estimatedPercentComplete)
            }
            .padding()
        }
        .accentColor(.orange)
        .onReceive(scanState.resultPublisher) { result in
            switch result {
            case .ur:
                ScanFeedback.success()
                estimatedPercentComplete = 1
                fragmentStates = [.highlighted]
                self.result = result
            case .other:
                ScanFeedback.success()
                estimatedPercentComplete = 1
                fragmentStates = [.highlighted]
                self.result = result
            case .progress(let p):
                ScanFeedback.progress()
                estimatedPercentComplete = p.estimatedPercentComplete
                fragmentStates = p.fragmentStates
                if startDate == nil {
                    startDate = Date()
                }
            case .reject:
                ScanFeedback.error()
            case .failure(let error):
                print("🛑 failure: \(error)")
                self.result = result
                canRestart = false
            }
        }
    }
}

struct Scanner_Previews: PreviewProvider {
    static var previews: some View {
        Scanner(isPresenting: .constant(true))
    }
}
