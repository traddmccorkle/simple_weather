//
//  SettingsView.swift
//  simple weather
//
//  Created by Tradd McCorkle on 4/11/23.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("temperatureUnit") private var selectedUnit: String = TemperatureUnit.fahrenheit.rawValue

    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: UnitSelectionView(selectedUnit: $selectedUnit)) {
                    HStack {
                        Text("Temperature Unit")
                        Spacer()
                        Text(selectedUnit)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct UnitSelectionView: View {
    @Binding var selectedUnit: String

    var body: some View {
        List(TemperatureUnit.allCases, id: \.rawValue) { unit in
            Button(action: {
                self.selectedUnit = unit.rawValue
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }) {
                HStack {
                    Text(unit.rawValue)
                    Spacer()
                    if unit.rawValue == selectedUnit {
                        Image(systemName: "checkmark")
                            .foregroundColor(.accentColor)
                    }
                }
            }
        }
        .navigationTitle("Select Unit")
    }
}

enum TemperatureUnit: String, CaseIterable {
    case fahrenheit = "Fahrenheit"
    case celsius = "Celsius"
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
