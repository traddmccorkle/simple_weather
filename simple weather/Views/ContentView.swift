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
                .navigationBarItems(
                    trailing:
                        Menu {
                            Button(action: {}) {
                                Label("Celsius °C", systemImage: "thermometer.sun.fill")
                            }
                            Button(action: {}) {
                                Label("Fahrenheit °F", systemImage: "thermometer.sun.fill")
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle")
                                .font(.system(size: 20))
                        }
                )
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
