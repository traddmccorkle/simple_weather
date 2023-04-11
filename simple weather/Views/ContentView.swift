//
//  ContentView.swift
//  simple weather
//
//  Created by Tradd McCorkle on 4/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingSettings = false
    
    var body: some View {
        NavigationView {
            WeatherView()
                .navigationBarItems(trailing:
                                        Button(action: {
                    self.isShowingSettings = true
                }) {
                    Image(systemName: "line.horizontal.3")
                }
                )
        }
        .sheet(isPresented: $isShowingSettings) {
            SettingsView()
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
