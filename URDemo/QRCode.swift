//
//  QRCode.swift
//  URDemo
//
//  Created by Wolf McNally on 7/5/20.
//  Copyright © 2020 Arciem LLC. All rights reserved.
//

import SwiftUI

public struct QRCode: View {
    @Binding var data: Data
    let foregroundColor: Color
    let backgroundColor: Color

    public init(data: Binding<Data>, foregroundColor: Color = .primary, backgroundColor: Color = .clear) {
        self._data = data
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }

    public var body: some View {
        return makeQRCode(data, correctionLevel: .low)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
    }
}

#if DEBUG
struct QRCode_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QRCode(data: Binding.constant("Hello".utf8))
        }.darkMode()
    }
}
#endif
