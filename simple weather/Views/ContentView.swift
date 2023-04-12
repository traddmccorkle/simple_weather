//
//  ContentView.swift
//  simple weather
//
//  Created by Tradd McCorkle on 4/11/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            WeatherView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
