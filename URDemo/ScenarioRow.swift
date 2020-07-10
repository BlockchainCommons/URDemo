//
//  ScenarioRow.swift
//  URDemo
//
//  Created by Wolf McNally on 7/5/20.
//  Copyright © 2020 Arciem LLC. All rights reserved.
//

import SwiftUI
import WolfSwiftUI

struct ScenarioRow: View {
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

struct ScenarioRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ScenarioRow(scenario: Scenario(name: "Test", messageLen: 1024, maxFragmentLen: 300))
        }
    .darkMode()
    }
}
