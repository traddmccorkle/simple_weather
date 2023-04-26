//
//  SettingsView.swift
//  simple weather
//
//  Created by Tradd McCorkle on 4/15/23.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var weatherAPI: WeatherAPI
    let weatherView = WeatherView()
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Units")) {
                    Button(action: {
                        weatherAPI.temperatureUnitImperial = true
                        print("Temperature unit set to Fahrenheit.")
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
                    Button(action: {
                        weatherAPI.temperatureUnitImperial = false
                        print("Temperature unit set to Celsius.")
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
                } // Units section close
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
