//
//  ContentView.swift
//
//  ContentView.swift
//  simple weather
//
//  Created by Tradd McCorkle on 4/11/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var weatherAPI = WeatherAPI()
    
    var body: some View {
        ZStack {
            TabView {
                WeatherView()
                    .environmentObject(weatherAPI)
                    .tabItem {
                        Label("Weather", systemImage: "sun.max.fill")
                    }
                SettingsView()
                    .environmentObject(weatherAPI)
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
