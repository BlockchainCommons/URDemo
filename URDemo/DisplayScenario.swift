//
//  DisplayScenario.swift
//
//  Copyright © 2020 by Blockchain Commons, LLC
//  Licensed under the "BSD-2-Clause Plus Patent License"
//

import SwiftUI
import URKit
import URUI
import LifeHash

protocol Preference { }

/// A View that displays a (possibly animated) QR code including a LifeHash of the data being sent
/// and a FragmentBar that shows which fragments are currently being displayed.
struct DisplayScenario: View {
    let scenario: Scenario
    @StateObject private var displayState: URDisplayState
    @StateObject private var lifeHashState: LifeHashState

    @Environment(\.horizontalSizeClass) var sizeClass

    init(scenario: Scenario) {
        self.scenario = scenario
        let ur = scenario.makeUR()
        self._displayState = StateObject(wrappedValue: URDisplayState(ur: ur, maxFragmentLen: scenario.maxFragmentLen))
        self._lifeHashState = StateObject(wrappedValue: LifeHashState(input: ur.cbor))
    }

    @State var columnWidth: CGFloat?

    func faster() {
        displayState.framesPerSecond = min(displayState.framesPerSecond + 1, 20)
    }

    func slower() {
        displayState.framesPerSecond = max(displayState.framesPerSecond - 1, 1.0)
    }

    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                HStack {
                    Text("length: \(scenario.messageLen)")
                    Text("maxFragment: \(scenario.maxFragmentLen)")
                    Text("parts: \(displayState.seqLen)")
                }
                .font(.caption)
                if !displayState.isSinglePart {
                    HStack {
                        Spacer()
                        Button {
                            displayState.restart()
                        } label: {
                            Image(systemName: "arrow.counterclockwise")
                        }
                    }
                }
            }
            VStack {
                URSummaryView(ur: displayState.ur, lifeHashState: lifeHashState)
                URQRCode(data: Binding.constant(displayState.part))
                    .frame(width: sizeClass == .regular ? 700 : 350)
                    .layoutPriority(1)
                    .background(GeometryReader {
                        Color.clear.preference(key: columnWidthKey, value: [$0.size.width])
                    })
                if !displayState.isSinglePart {
                    URFragmentBar(states: Binding.constant(displayState.fragmentStates))
                        .background(GeometryReader {
                            Color.clear.preference(key: columnWidthKey, value: [$0.size.width])
                        })
                    Text("\(displayState.seqNum)").font(Font.system(.headline).bold().monospacedDigit())
                    HStack(spacing: 40) {
                        IconButton(imageName: "tortoise.fill") { slower() }
                        Text("\(displayState.framesPerSecond, specifier: "%.0f") fps").font(Font.system(.headline).bold().monospacedDigit())
                        IconButton(imageName: "hare.fill") { faster() }
                    }
                }
                Spacer()
            }
        }
        .frame(width: columnWidth)
        .padding()
        .navigationBarTitle(scenario.name)
        .onAppear {
            displayState.run()
        }
        .onDisappear {
            displayState.stop()
        }
        .onPreferenceChange(columnWidthKey) { prefs in
            let minPref = prefs.reduce(CGFloat.infinity, min)
            if minPref > 0 {
                columnWidth = minPref
            }
        }
    }

    struct AppendValue<T: Preference>: PreferenceKey {
        static var defaultValue: [CGFloat] { [] }
        static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
            value.append(contentsOf: nextValue())
        }
    }

    enum ColumnWidth: Preference { }
    let columnWidthKey = AppendValue<ColumnWidth>.self
}

struct DisplayScenario_Previews: PreviewProvider {
    static let scenario = Scenario(name: "A", messageLen: 1024, maxFragmentLen: 100)

    static var previews: some View {
        NavigationView {
            DisplayScenario(scenario: Self.scenario)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .darkMode()
    }
}
