//
//  IconButton.swift
//
//  Created by Wolf McNally on 11/27/20.
//  Copyright © 2020 Arciem LLC. All rights reserved.
//

import SwiftUI

struct IconButton: View {
    let imageName: String
    let action: () -> Void

    init(imageName: String, action: @escaping () -> Void) {
        self.action = action
        self.imageName = imageName
    }

    var body: some View {
        Button(action: action) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .frame(width: 32)
    }
}
