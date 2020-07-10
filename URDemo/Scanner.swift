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
    @ObservedObject var session: ScannerSession

    var body: some View {
        VStack {
            ScanTopBar(isPresenting: _isPresenting, restart: self.session.restart )
            Spacer()
            if session.result != nil {
                ScanCompleteView(result: session.result!, elapsed: session.elapsedTime)
            } else {
                ScanCameraView(isPresenting: _isPresenting, session: session)
            }
            Spacer()
        }
        .accentColor(.orange)
    }
}

struct Scanner_Previews: PreviewProvider {
    static var previews: some View {
        Scanner(isPresenting: Binding.constant(true), session: ScannerSession())
    }
}
