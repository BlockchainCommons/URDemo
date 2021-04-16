//
//  ScanControls.swift
//
//  Copyright © 2020 by Blockchain Commons, LLC
//  Licensed under the "BSD-2-Clause Plus Patent License"
//

import SwiftUI

struct ScanControls: View {
    @Binding var isPresenting: Bool
    @Binding var canRestart: Bool
    let restart: () -> Void

    var body: some View {
        HStack {
            Button {
                self.isPresenting = false
            } label: {
                Text("Done").bold()
            }
            Spacer()

            if canRestart {
                Button {
                    self.restart()
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .imageScale(.medium)
                }
            }
        }
        .padding()
    }
}

struct ScanControls_Previews: PreviewProvider {
    static var previews: some View {
        ScanControls(isPresenting: .constant(true), canRestart: .constant(true), restart: { })
            .previewLayout(.sizeThatFits)
    }
}
