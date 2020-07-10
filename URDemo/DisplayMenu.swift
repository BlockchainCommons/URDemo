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
        Scenario(name: "Sm Single Part", messageLen: 300, maxFragmentLen: 500),
        Scenario(name: "Lg Single Part", messageLen: 800, maxFragmentLen: 1000),
        Scenario(name: "Sm, X-Sm Frags", messageLen: 300, maxFragmentLen: 100),
        Scenario(name: "Lg, Sm Frags", messageLen: 1024, maxFragmentLen: 250),
        Scenario(name: "X-Lg, X-Sm Frags", messageLen: 10000, maxFragmentLen: 100),
        Scenario(name: "X-Lg, Sm Frags", messageLen: 10000, maxFragmentLen: 250),
        Scenario(name: "X-Lg, Lg Frags", messageLen: 10000, maxFragmentLen: 500),
        Scenario(name: "X-Lg, X-Lg Frags", messageLen: 10000, maxFragmentLen: 700)
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
