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
                Section(header: Text("General")) {
                    Button(action: {
                        weatherAPI.temperatureUnitImperial = true
                    }) {
                        HStack {
                            Text("Fahrenheit °F")
                            Spacer()
                            if weatherAPI.temperatureUnitImperial == false {
                                Image(systemName: "circle")
                            } else {
                                Image(systemName: "checkmark.circle.fill")
                            }
                        }
                    }
                }
                Button(action: {
                    weatherAPI.temperatureUnitImperial = false
                }) {
                    HStack {
                        Text("Celsius °C")
                        Spacer()
                        if weatherAPI.temperatureUnitImperial == true {
                            Image(systemName: "circle")
                        } else {
                            Image(systemName: "checkmark.circle.fill")
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
