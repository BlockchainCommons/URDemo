//
//  TopView.swift
//  URDemo
//
//  Created by Wolf McNally on 7/5/20.
//  Copyright © 2020 Arciem LLC. All rights reserved.
//

import SwiftUI
import URKit
import WolfSwiftUI

struct TopView: View {
    @State var isPresentingScanner: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                DisplayMenu()
                IconButton(icon: Image(systemName: "qrcode.viewfinder")) {
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
