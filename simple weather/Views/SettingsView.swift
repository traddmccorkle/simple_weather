//
//  SettingsView.swift
//  simple weather
//
//  Created by Tradd McCorkle on 4/15/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var weatherAPI: WeatherAPI
    @EnvironmentObject var globalVariables: GlobalVariables
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Units")) {
                    Button(action: {
                        globalVariables.globalTemperatureUnit = "imperial"
                    }) {
                        HStack {
                            Text("Fahrenheit °F")
                            Spacer()
                            if globalVariables.globalTemperatureUnit == "metric" {
                                Image(systemName: "circle")
                            } else if globalVariables.globalTemperatureUnit == "imperial" {
                                Image(systemName: "checkmark.circle.fill")
                            }
                        }
                    }
                    Button(action: {
                        globalVariables.globalTemperatureUnit = "metric"
                    }) {
                        HStack {
                            Text("Celsius °C")
                            Spacer()
                            if globalVariables.globalTemperatureUnit == "imperial" {
                                Image(systemName: "circle")
                            } else if globalVariables.globalTemperatureUnit == "metric" {
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
