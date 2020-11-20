//
//  Scanner.swift
//  URDemo
//
//  Created by Wolf McNally on 7/8/20.
//  Copyright © 2020 Arciem LLC. All rights reserved.
//

import SwiftUI
import URKit

struct Scanner: View {
    @Binding var isPresenting: Bool
    @StateObject var scanState: ScanState = ScanState()

    var body: some View {
        VStack {
            ScanControls(isPresenting: _isPresenting, restart: self.scanState.restart )
            Spacer()
            if scanState.result != nil {
                ScanCompleteView(result: scanState.result!, elapsed: scanState.elapsedTime)
            } else {
                VideoView(codesPublisher: scanState.codesPublisher)
            }
            Spacer()
            FragmentBar(views: $scanState.fragmentViews)
            ProgressBar(value: $scanState.estimatedPercentComplete).frame(height: 10)
        }
        .accentColor(.orange)
    }
}

struct Scanner_Previews: PreviewProvider {
    static var previews: some View {
        Scanner(isPresenting: Binding.constant(true), scanState: ScanState())
    }
}
