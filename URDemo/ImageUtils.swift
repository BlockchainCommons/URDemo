//
//  ImageUtils.swift
//  URDemo
//
//  Created by Wolf McNally on 7/6/20.
//  Copyright © 2020 Arciem LLC. All rights reserved.
//

import UIKit
import Foundation
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

public enum CorrectionLevel: String {
    case low = "L"
    case medium = "M"
    case quartile = "Q"
    case high = "H"
}

func makeQRCode(_ message: Data, correctionLevel: CorrectionLevel = .medium) -> Image {
    let qrCodeGenerator = CIFilter.qrCodeGenerator()
    qrCodeGenerator.correctionLevel = correctionLevel.rawValue
    qrCodeGenerator.message = message

    let falseColor = CIFilter.falseColor()
    falseColor.inputImage = qrCodeGenerator.outputImage
    falseColor.color0 = .black
    falseColor.color1 = .clear

    let output = falseColor.outputImage!

    let cgImage = CIContext().createCGImage(output, from: output.extent)!
    return Image(uiImage: UIImage(cgImage: cgImage, scale: 1, orientation: .up))
        .renderingMode(.template)
        .interpolation(.none)
}
