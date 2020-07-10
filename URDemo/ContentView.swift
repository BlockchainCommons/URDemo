//
//  MainMenu.swift
//  URDemo
//
//  Created by Wolf McNally on 7/5/20.
//  Copyright © 2020 Arciem LLC. All rights reserved.
//

import SwiftUI
import URKit

struct MainMenu: View {
    var body: some View {
        NavigationView {
            List {
                Text("Hello, World!")
            }
        .navigationBarTitle("URKit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
