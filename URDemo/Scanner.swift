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
    @StateObject var scanState = URScanState(feedbackProvider: ScanFeedback())

    var body: some View {
        VStack {
            ScanControls(isPresenting: _isPresenting, isDone: $scanState.isDone, restart: self.scanState.restart )
            Spacer()
            if let result = scanState.result {
                ScanCompleteView(result: result, elapsed: scanState.elapsedTime)
            } else {
                URVideo(scanState: scanState)
            }
            Spacer()
            VStack {
                URFragmentBar(states: $scanState.fragmentStates)
                URProgressBar(value: $scanState.estimatedPercentComplete)
            }
            .padding()
        }
        .accentColor(.orange)
    }
}

struct Scanner_Previews: PreviewProvider {
    static var previews: some View {
        Scanner(isPresenting: Binding.constant(true), scanState: URScanState())
    }
}
