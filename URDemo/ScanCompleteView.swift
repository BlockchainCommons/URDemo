//
//  ScanCompleteView.swift
//
//  Copyright © 2020 by Blockchain Commons, LLC
//  Licensed under the "BSD-2-Clause Plus Patent License"
//

import SwiftUI
import URKit
import WolfSwiftUI
import LifeHash
import URUI
import WolfBase

let nanosecondsPerSecond: UInt64 = 1_000_000_000

struct ScanCompleteView: View {
    let result: URScanResult
    let elapsed: TimeInterval
    @State private var isMessageVisible: Bool = false

    static let copied = FeedbackGenerator(haptic: .heavy)

    var body: some View {
        VStack(spacing: 20) {
            containedView
            if let copyValue = copyValue {
                Button {
                    UIPasteboard.general.string = copyValue
                    confirmCopy()
                } label: {
                    Label("Copy", systemImage: "doc.on.doc")
                }
                .buttonStyle(.borderedProminent)
            }
            Text("Copied!")
                .bold()
                .opacity(isMessageVisible ? 1 : 0)
        }
    }

    func confirmCopy() {
        Self.copied.play()
        withAnimation(.easeIn(duration: 0.05)) {
            isMessageVisible = true
        }
        Task {
            await removeMessage()
        }
    }

    func removeMessage() async {
        try! await Task.sleep(seconds: 1)
        withAnimation {
            isMessageVisible = false
        }
    }
    
    var copyValue: String? {
        switch result {
        case .ur(let ur):
            return ur.string
        case .other(let string):
            return string
        default:
            return nil
        }
    }

    var containedView: AnyView {
        switch result {
        case .ur(let ur):
            return VStack {
                URSummaryView(ur: ur, lifeHashState: LifeHashState(input: ur.cbor.cborData))
                Spacer().frame(height: 20)
                if elapsed > 0 {
                    Text("Elapsed time: \(elapsed, specifier: "%0.1f")s")
                    Text("Bytes/s: \(Double(ur.cbor.cborData.count) / elapsed, specifier: "%0.1f")")
                }
            }
            .eraseToAnyView()
        case .other(let string):
            return ScrollView {
                VStack(spacing: 10) {
                    Text("Scanned non-UR QR Code:")
                        .font(.body)
                        .bold()
                    Text(string)
                        .font(.system(.body, design: .monospaced)).bold()
                }
            }
            .padding()
            .eraseToAnyView()
        case .failure(let error):
            return Text("🛑 \(error.localizedDescription)")
                .eraseToAnyView()
        default:
            fatalError()
        }
    }
}

struct ScanCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        try! ScanCompleteView(result: .ur(UR(type: "bytes", cbor: Data.random(100).cbor)), elapsed: 20)
    }
}
