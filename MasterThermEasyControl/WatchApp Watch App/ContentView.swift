//
//  ContentView.swift
//  WatchApp Watch App
//
//  Created by Lukas Jezny on 26.10.2022.
//  Copyright © 2022 Lukas Jezny. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
