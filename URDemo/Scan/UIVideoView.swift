//
//  UIVideoView.swift
//  URDemo
//
//  Created by Wolf McNally on 11/19/20.
//  Copyright © 2020 Arciem LLC. All rights reserved.
//

import UIKit
import AVFoundation

class UIVideoView: UIView {
    private let videoSession: VideoSession

    init(codesPublisher: CodesPublisher) {
        videoSession = VideoSession(codesPublisher: codesPublisher)
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        guard let previewLayer = videoSession.previewLayer else { return }
        layer.addSublayer(previewLayer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        syncVideoSizeAndOrientation()
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if superview != nil {
            videoSession.startRunning()
        } else {
            videoSession.stopRunning()
        }
    }

    private func syncVideoSizeAndOrientation() {
        guard let previewLayer = videoSession.previewLayer else { return }
        previewLayer.frame = bounds
        if let connection = videoSession.captureSession?.connections.last, connection.isVideoOrientationSupported {
            let orientation = UIApplication.shared.windows.first!.windowScene!.interfaceOrientation
            connection.videoOrientation = AVCaptureVideoOrientation(rawValue: orientation.rawValue) ?? .portrait
        }
    }
}
