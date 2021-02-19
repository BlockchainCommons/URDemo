//
//  ScanCompleteView.swift
//
//  Copyright © 2020 by Blockchain Commons, LLC
//  Licensed under the "BSD-2-Clause Plus Patent License"
//

import SwiftUI
import URKit
import WolfSwiftUI
import LifeHash
import URUI

struct ScanCompleteView: View {
    let result: URScanResult
    let elapsed: TimeInterval

    var body: some View {
        containedView
    }

    var containedView: AnyView {
        switch result {
        case .ur(let ur):
            return VStack {
                URSummaryView(ur: ur, lifeHashState: LifeHashState(input: ur.cbor))
                Spacer().frame(height: 20)
                if elapsed > 0 {
                    Text("Elapsed time: \(elapsed, specifier: "%0.1f")s")
                    Text("Bytes/s: \(Double(ur.cbor.count) / elapsed, specifier: "%0.1f")")
                }
            }
            .eraseToAnyView()
        case .other(let string):
            return ScrollView {
                VStack(spacing: 10) {
                    Text("Scanned non-UR QR Code:")
                        .font(.title)
                        .bold()
                    Text(string)
                        .font(Font.system(.body, design: .monospaced))
                }
            }
            .padding()
            .eraseToAnyView()
        case .failure(let error):
            return Text("🛑 \(error.localizedDescription)")
                .eraseToAnyView()
        }
    }
}

struct ScanCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        try! ScanCompleteView(result: .ur(UR(type: "bytes", cbor: Data.random(100))), elapsed: 20)
    }
}
