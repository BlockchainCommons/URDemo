//
//  URSummaryView.swift
//
//  Copyright © 2020 by Blockchain Commons, LLC
//  Licensed under the "BSD-2-Clause Plus Patent License"
//

import SwiftUI
import URKit
import LifeHash

struct URSummaryView: View {
    let ur: UR
    @ObservedObject var lifeHashState: LifeHashState

    var body: some View {
        VStack {
            // Don't show LifeHash for other UR types, because we don't know how to properly make a digest of them.
            if ur.type == "bytes" {
                LifeHashView(state: lifeHashState){
                    Rectangle()
                        .fill(Color.gray)
                }
                    .frame(height: 128)
            }
            Text("ur:\(ur.type)/<\(String(ur.cbor.cborData.count))>").font(.system(.body, design: .monospaced)).bold()
        }
    }
}

struct URSummaryView_Previews: PreviewProvider {
    static let ur = try! UR(type: "bytes", cbor: Data.random(100).cbor)
    static let lifeHashState = LifeHashState(input: ur.cbor.cborData)
    static var previews: some View {
        return URSummaryView(ur: ur, lifeHashState: lifeHashState)
    }
}
