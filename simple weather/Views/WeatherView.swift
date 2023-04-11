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
    
    @State public var temperature: String = ""
    @State public var currentLocation: String = ""
    
    var body: some View {
        VStack {
            if temperature.isEmpty {
                //Displays progress circle until weather updates
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                Text("\(currentLocation)")
                    .font(.system(.largeTitle, design: .rounded))
                Text("\(temperature)°F")
                    .font(.system(.largeTitle, design: .rounded))
            }
        }
        .padding()
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
            WeatherView()
        }
    }
}
