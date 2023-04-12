//
//  WeatherView.swift
//  simple weather
//
//  Created by Tradd McCorkle on 4/11/23.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    let weatherAPI = WeatherAPI()
    
    @State private var temperature: String = ""
    @State private var currentLocation: String = ""
    
    init(temperature: String = "", currentLocation: String = "") {
            _temperature = State(initialValue: temperature)
            _currentLocation = State(initialValue: currentLocation)
        }//Used for preview provider
    
    var body: some View {
        VStack {
            if temperature.isEmpty {
                //Displays progress circle until weather updates
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                Text("\(temperature)°F")
                    .font(.system(.largeTitle, design: .rounded))
            }
        }
        .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(currentLocation)
                            .font(.headline)
                    }
                } //Displays current location at the top of the app
        .onAppear() { //Updates weather when this view appears
            getCurrentWeather()
        }
    }
    
    func getCurrentWeather() { //Uses WeatherAPI to update weather to current location
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
        
        guard locationManager.location != nil else {
            print("Unable to get user location.")
            return
        }//Checks to see if currentLocation is nil
        
        weatherAPI.getWeatherDataForCurrentLocation { (weatherData, error) in
            if let error = error {
                print("Error getting weather data: \(error.localizedDescription)")
            } else if let weatherData = weatherData {
                let temperatureInFahrenheit = Int(weatherData.main.temp)
                self.temperature = String(temperatureInFahrenheit)
                self.currentLocation = weatherData.name
            }
        }
    }
    
    struct WeatherView_Previews: PreviewProvider {
        static var previews: some View {
            WeatherView(temperature: "69", currentLocation: "Sample City")
        }
    }
}
