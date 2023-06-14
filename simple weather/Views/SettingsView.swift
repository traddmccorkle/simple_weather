//
//  SettingsView.swift
//  simple weather
//
//  Created by Tradd McCorkle on 4/15/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var weatherAPI: WeatherAPI
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Units")) {
                    Button(action: {
                        weatherAPI.temperatureUnit = "imperial"
                    }) {
                        HStack {
                            Text("Fahrenheit °F")
                            Spacer()
                            if weatherAPI.temperatureUnit == "metric" {
                                Image(systemName: "circle")
                            } else if weatherAPI.temperatureUnit == "imperial" {
                                Image(systemName: "checkmark.circle.fill")
                            }
                        }
                    }
                    Button(action: {
                        weatherAPI.temperatureUnit = "metric"
                    }) {
                        HStack {
                            Text("Celsius °C")
                            Spacer()
                            if weatherAPI.temperatureUnit == "imperial" {
                                Image(systemName: "circle")
                            } else if weatherAPI.temperatureUnit == "metric" {
                                Image(systemName: "checkmark.circle.fill")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
