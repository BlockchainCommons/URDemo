//
//  ScanControls.swift
//  URDemo
//
//  Created by Wolf McNally on 7/8/20.
//  Copyright © 2020 Arciem LLC. All rights reserved.
//

import SwiftUI

struct ScanControls: View {
    @Binding var isPresenting: Bool
    let restart: () -> Void

    var body: some View {
        HStack {
            Button {
                self.isPresenting = false
            } label: {
                Text("Done").bold()
            }
            Spacer()
            Button {
                self.restart()
            } label: {
                Image(systemName: "arrow.counterclockwise")
                    .imageScale(.medium)
            }
        }
        .padding()
    }
}

struct ScanControls_Previews: PreviewProvider {
    static var previews: some View {
        ScanControls(isPresenting: Binding.constant(true), restart: { })
            .previewLayout(.sizeThatFits)
    }
}
