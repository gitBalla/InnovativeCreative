//
//  ContentView.swift
//  InnovativeCreative
//
//  Created by John Balla on 21/6/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ActivityView()
                .tabItem {
                    Image(systemName: "leaf")
                    Text("Activity")
                }
            RecycleView()
                .tabItem {
                    Image(systemName: "arrow.3.trianglepath")
                    Text("Recycle")
                }
            HistoryView()
                .tabItem {
                    Image(systemName: "book")
                    Text("History")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
