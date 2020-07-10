//
//  ScanCameraView.swift
//  URDemo
//
//  Created by Wolf McNally on 7/8/20.
//  Copyright © 2020 Arciem LLC. All rights reserved.
//

import SwiftUI

struct ScanCameraView: View {
    @Binding var isPresenting: Bool
    @ObservedObject var session: ScannerSession

    var body: some View {
        VStack {
            CodeScannerView(
                codeTypes: [.qr],
                completion: { result in
                    switch result {
                    case .success(let codes):
                        self.session.receiveParts(codes)
                    case .failure(let error):
                        print(error)
                        beepError.play()
                        self.isPresenting = false
                    }
            }
            )
            FragmentBar(views: $session.fragmentViews)
            ProgressBar(value: $session.estimatedPercentComplete).frame(height: 10)
        }

    }
}

struct ScanCameraView_Previews: PreviewProvider {
    static var previews: some View {
        ScanCameraView(isPresenting: Binding.constant(true), session: ScannerSession())
        .padding()
    }
}
