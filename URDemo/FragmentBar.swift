//
//  FragmentBar.swift
//  URDemo
//
//  Created by Wolf McNally on 7/7/20.
//  Copyright © 2020 Arciem LLC. All rights reserved.
//

import Foundation
import SwiftUI

struct FragmentBar: View {
    @Binding var views: [AnyView]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<views.count, id: \.self) { i in
                self.views[i]
            }
        }
        .frame(height: 20)
    }
}

struct FragmentBar_Previews: PreviewProvider {
    static let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .black, .white]
    static let views: [AnyView] = colors.map { AnyView($0) }

    static var previews: some View {
        NavigationView {
            FragmentBar(views: Binding.constant(Self.views))
            .padding()
        }
    .darkMode()
    }
}
