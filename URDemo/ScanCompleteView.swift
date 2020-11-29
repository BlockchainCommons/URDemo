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

struct ScanCompleteView: View {
    let result: Result<UR, Error>
    let elapsed: TimeInterval

    var body: some View {
        containedView
    }

    var containedView: AnyView {
        switch result {
        case .success(let ur):
            return AnyView(
                VStack {
                    URSummaryView(ur: ur, lifeHashState: LifeHashState(input: ur.cbor))
                    Spacer().frame(height: 20)
                    if elapsed > 0 {
                        Text("Elapsed time: \(elapsed, specifier: "%0.1f")s")
                        Text("Bytes/s: \(Double(ur.cbor.count) / elapsed, specifier: "%0.1f")")
                    }
                }
            )
        case .failure(let error):
            return AnyView(Text("🛑 \(error.localizedDescription)"))
        }
    }
}

struct ScanCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        try! ScanCompleteView(result: .success(UR(type: "bytes", cbor: Data.random(100))), elapsed: 20)
    }
}
