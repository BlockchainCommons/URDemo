//
//  ScenarioMenuItem.swift
//
//  Copyright © 2020 by Blockchain Commons, LLC
//  Licensed under the "BSD-2-Clause Plus Patent License"
//

import SwiftUI
import WolfSwiftUI

/// A View that displays the details of a `Scenario` for possible selection.
struct ScenarioMenuItem: View {
    let scenario: Scenario

    var body: some View {
        HStack {
            Image(systemName: "qrcode")
                .font(Font.title.weight(.semibold))
                .foregroundColor(.accentColor)
            VStack(alignment: .leading) {
                Text(scenario.name)
                    .font(Font.body.weight(.semibold))
                HStack {
                    Text("length: \(scenario.messageLen)")
                    Text("maxFragment: \(scenario.maxFragmentLen)")
                }.font(.caption).foregroundColor(.secondary)
            }
        }
    }
}

struct ScenarioMenuItem_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ScenarioMenuItem(scenario: Scenario(name: "Test", messageLen: 1024, maxFragmentLen: 300))
        }
    .darkMode()
    }
}
