//
//  ScenarioMenu.swift
//
//  Copyright © 2020 by Blockchain Commons, LLC
//  Licensed under the "BSD-2-Clause Plus Patent License"
//

import SwiftUI
import WolfSwiftUI

/// A view that lists the scenarios and lets the user select one for display.
struct ScenarioMenu: View {
    var body: some View {
        List(scenarios) { scenario in
            NavigationLink(destination: LazyView(DisplayScenario(scenario: scenario))) {
                ScenarioMenuItem(scenario: scenario)
            }
        }
    }
}

struct DisplayMenu_Previews: PreviewProvider {
    static var previews: some View {
        ScenarioMenu()
        .darkMode()
    }
}
