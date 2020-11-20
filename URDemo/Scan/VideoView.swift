//
//  CodeScannerView.swift
//  URDemo
//
//  Created by Wolf McNally on 7/8/20.
//  Copyright © 2020 Arciem LLC. All rights reserved.
//

import SwiftUI

struct VideoView: UIViewRepresentable {
    let codesPublisher: CodesPublisher

    func makeUIView(context: Context) -> UIVideoView {
        UIVideoView(codesPublisher: codesPublisher)
    }

    func updateUIView(_ uiView: UIVideoView, context: Context) {
    }
}
