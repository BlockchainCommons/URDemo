//
//  VideoSession.swift
//  URDemo
//
//  Created by Wolf McNally on 11/17/20.
//  Copyright © 2020 Arciem LLC. All rights reserved.
//

import Foundation
import AVFoundation
import Combine

public struct VideoSessionError: LocalizedError {
    public let description: String

    public init(_ description: String) {
        self.description = description
    }

    public var errorDescription: String? {
        return description
    }
}

public final class VideoSession {
    public private(set) var captureSession: AVCaptureSession!
    public private(set) var previewLayer: AVCaptureVideoPreviewLayer?
    private let codesPublisher: CodesPublisher
    private var metadataObjectsDelegate: MetadataObjectsDelegate!
    let queue = DispatchQueue(label: "codes", qos: .userInteractive)

    public init(codesPublisher: CodesPublisher) {
        self.codesPublisher = codesPublisher

        do {
            #if targetEnvironment(simulator)

            throw VideoSessionError("Video capture not available in the simulator.")

            #else

            captureSession = AVCaptureSession()

            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
                throw VideoSessionError("Could not open video capture device.")
            }

            let videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            guard captureSession.canAddInput(videoInput) else {
                throw VideoSessionError("Could not add video input device.")
            }
            captureSession.addInput(videoInput)

            metadataObjectsDelegate = MetadataObjectsDelegate(codesPublisher: codesPublisher)

            let metadataOutput = AVCaptureMetadataOutput()
            guard captureSession.canAddOutput(metadataOutput) else {
                throw VideoSessionError("Could not add metadata output.")
            }
            captureSession.addOutput(metadataOutput)

            metadataOutput.metadataObjectTypes = [.qr]
            metadataOutput.setMetadataObjectsDelegate(metadataObjectsDelegate, queue: queue)

            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer!.videoGravity = .resizeAspectFill
            #endif
        } catch {
            print("🛑 \(error)")
            codesPublisher.send(completion: .failure(error))
        }
    }

    public func startRunning() {
        guard let captureSession = captureSession else { return }
        if !captureSession.isRunning {
            captureSession.startRunning()
        }
    }

    public func stopRunning() {
        guard let captureSession = captureSession else { return }
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }

    public var isRunning: Bool {
        captureSession?.isRunning ?? false
    }

    @objc
    class MetadataObjectsDelegate: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        let codesPublisher: CodesPublisher
        var lastFound: Set<String> = []

        init(codesPublisher: CodesPublisher) {
            self.codesPublisher = codesPublisher
        }

        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            let codes = Set(metadataObjects.compactMap {
                ($0 as? AVMetadataMachineReadableCodeObject)?.stringValue
            })
            if !codes.isEmpty, !codes.isSubset(of: lastFound) {
                lastFound = codes
                codesPublisher.send(codes)
            }
        }
    }
}
