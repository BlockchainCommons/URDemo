//
//  IconButton.swift
//  URDemo
//
//  Created by Wolf McNally on 11/19/20.
//  Copyright © 2020 Arciem LLC. All rights reserved.
//

import SwiftUI

struct IconButton: View {
    let icon: Image
    let action: () -> Void

    var body: some View {
        return Button(action: action) {
            icon
                .font(.largeTitle)
        }
    }
}
