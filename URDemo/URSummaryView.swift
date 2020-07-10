//
//  URSummaryView.swift
//  URDemo
//
//  Created by Wolf McNally on 7/8/20.
//  Copyright © 2020 Arciem LLC. All rights reserved.
//

import SwiftUI
import URKit
import LifeHash

struct URSummaryView: View {
    @Binding var ur: UR
    @ObservedObject var lifeHashState: LifeHashState

    let missingView: some View = Rectangle().foregroundColor(.secondary).opacity(0.5)

    var body: some View {
        VStack {
            LifeHashView(state: lifeHashState, missingView: missingView)
                .frame(height: 128)
            Text("ur:\(ur.type)/<\(String(ur.cbor.count))>").font(.system(.caption, design: .monospaced)).bold()
        }
    }
}

struct URSummaryView_Previews: PreviewProvider {
    static let ur = try! UR(type: "bytes", cbor: Data.random(100))
    static let lifeHashState = LifeHashState(input: ur.cbor)
    static var previews: some View {
        return URSummaryView(ur: Binding.constant(ur), lifeHashState: lifeHashState)
    }
}
