//
//  ScanControls.swift
//
//  Copyright © 2020 by Blockchain Commons, LLC
//  Licensed under the "BSD-2-Clause Plus Patent License"
//

import SwiftUI

struct ScanControls: View {
    @Binding var isPresenting: Bool
    @Binding var isDone: Bool
    let restart: () -> Void

    var body: some View {
        HStack {
            Button {
                self.isPresenting = false
            } label: {
                Text("Done").bold()
            }
            Spacer()

            if !isDone {
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
        ScanControls(isPresenting: Binding.constant(true), isDone: Binding.constant(false), restart: { })
            .previewLayout(.sizeThatFits)
    }
}
