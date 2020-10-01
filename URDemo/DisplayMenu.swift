//
//  DisplayMenu.swift
//  URDemo
//
//  Created by Wolf McNally on 7/5/20.
//  Copyright © 2020 Arciem LLC. All rights reserved.
//

import SwiftUI
import WolfSwiftUI

struct DisplayMenu: View {
    let scenarios = [
        Scenario(name: "300b, Single Part", messageLen: 300, maxFragmentLen: 500),
        Scenario(name: "800b, Single Part", messageLen: 800, maxFragmentLen: 1_000),
        Scenario(name: "300b, 100b Frags", messageLen: 300, maxFragmentLen: 100),
        Scenario(name: "1K, 250b Frags", messageLen: 1_024, maxFragmentLen: 250),
        Scenario(name: "10K, 100b Frags", messageLen: 10_000, maxFragmentLen: 100),
        Scenario(name: "10K, 250b Frags", messageLen: 10_000, maxFragmentLen: 250),
        Scenario(name: "10K, 500b Frags", messageLen: 10_000, maxFragmentLen: 500),
        Scenario(name: "10K, 700b Frags", messageLen: 10_000, maxFragmentLen: 700)
    ]

    var body: some View {
        List(scenarios) { scenario in
            NavigationLink(destination: LazyView(DisplayScenario(scenario: scenario))) {
                ScenarioRow(scenario: scenario)
            }
        }
    }
}

struct DisplayMenu_Previews: PreviewProvider {
    static var previews: some View {
        DisplayMenu()
        .darkMode()
    }
}
