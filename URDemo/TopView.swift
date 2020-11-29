//
//  TopView.swift
//
//  Copyright © 2020 by Blockchain Commons, LLC
//  Licensed under the "BSD-2-Clause Plus Patent License"
//

import SwiftUI
import URKit
import WolfSwiftUI

// The top-level View of the app that displays the scenario menu and a button that initiates a scan.
struct TopView: View {
    @State var isPresentingScanner: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                ScenarioMenu()
                IconButton(imageName: "qrcode.viewfinder") {
                    self.isPresentingScanner = true
                }
                .sheet(isPresented: $isPresentingScanner) {
                    LazyView( Scanner(isPresenting: self.$isPresentingScanner) )
                }
                .padding()
            }
            .navigationBarTitle("URKit Demo")
        }
        .accentColor(.orange)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
            .darkMode()
    }
}
