//
//  SettingsView.swift
//  simple weather
//
//  Created by Tradd McCorkle on 4/11/23.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Settings View.")
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
