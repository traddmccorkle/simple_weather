//
//  GlobalVariables.swift
//  simple weather
//
//  Created by Tradd McCorkle on 4/27/23.
//

import Foundation
import Combine

class GlobalVariables: ObservableObject {
    @Published public var globalTemperatureUnit = "imperial"
}
