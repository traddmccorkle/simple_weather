//
//  SettingsView.swift
//  simple weather
//
//  Created by Tradd McCorkle on 4/15/23.
//

import SwiftUI

struct SettingsView: View {
    
    let weatherView = WeatherView()
    @ObservedObject var globalVariables = GlobalVariables()
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Units")) {
                    Button(action: {
                        if globalVariables.globalTemperatureUnit == "imperial" {
                            print("The temperature unit is already set to Fahrenheit.")
                        } else if globalVariables.globalTemperatureUnit == "metric" {
                            globalVariables.globalTemperatureUnit = "imperial"
                            print("Temperature unit set to Fahrenheit.")
                        }
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
                        if globalVariables.globalTemperatureUnit == "metric" {
                            print("The temperature unit is already set to Celsius.")
                        } else if globalVariables.globalTemperatureUnit == "imperial" {
                            globalVariables.globalTemperatureUnit = "metric"
                            print("Temperature unit set to Celsius.")
                        }
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
