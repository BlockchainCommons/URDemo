//
//  ScanTopBar.swift
//  URDemo
//
//  Created by Wolf McNally on 7/8/20.
//  Copyright © 2020 Arciem LLC. All rights reserved.
//

import SwiftUI

struct ScanTopBar: View {
    @Binding var isPresenting: Bool
    let restart: () -> Void

    var body: some View {
        HStack {
            Button(action: { self.isPresenting = false }) {
                Text("Done").bold()
            }
            Spacer()
            Button(action: { self.restart() }) {
                Image(systemName: "arrow.counterclockwise").imageScale(.medium)
            }
        }
        .padding()
    }
}

struct ScanTopBar_Previews: PreviewProvider {
    static var previews: some View {
        ScanTopBar(isPresenting: Binding.constant(true), restart: { })
            .previewLayout(.sizeThatFits)
    }
}
