//
//  WeatherView.swift
//  simple weather
//
//  Created by Tradd McCorkle on 4/11/23.
//

import SwiftUI
import CoreLocation

struct WeatherView: View {
    @EnvironmentObject var weatherAPI: WeatherAPI
    
    @State private var currentLocation: String?
    @State private var temperature: Double = 0
    @State private var highTemperature: Double = 0
    @State private var lowTemperature: Double = 0
    @State private var weatherCondition: String?
    
    var body: some View {
        VStack {
            ZStack {
                Image("WeatherBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        Text("\(currentLocation ?? "")")
                            .font(.system(size: 30.0, design: .rounded))
                            .foregroundColor(.white)
                        Image(systemName: "location.fill")
                            .font(.system(size: 20, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.trailing, 2)
                    }
                    HStack {
                        VStack {
                            Text(weatherEmoji())
                                .font(.system(size: 125.0, design: .rounded))
                        }
                        VStack {
                            Text("\(String(format: "%g", round(temperature)))°")
                                .font(.system(size: 100.0, design: .rounded))
                                .foregroundColor(.white)
                        }
                    }
                    HStack {
                        Text("H:\(String(format: "%g", round(highTemperature)))°")
                            .font(.system(size: 20.0, design: .rounded))
                            .foregroundColor(.white)
                        Text("L:\(String(format: "%g", round(lowTemperature)))°")
                            .font(.system(size: 20.0, design: .rounded))
                            .foregroundColor(.white)
                    }
                }
                .onAppear() {
                    getCurrentWeather()
                }
            }
        }.foregroundStyle(Color.white)
    }
    
    func getCurrentWeather() {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
        
        guard locationManager.location != nil else {
            print("Unable to get user location.")
            return
        }
        
        weatherAPI.getWeatherDataForCurrentLocation(temperatureUnit: weatherAPI.temperatureUnit) { (weatherData, error) in
            if let error = error {
                print("Error getting weather data: \(error.localizedDescription)")
            } else if let weatherData = weatherData {
                self.temperature = weatherData.main.temp
                self.currentLocation = weatherData.name
                self.highTemperature = weatherData.main.temp_max
                self.lowTemperature = weatherData.main.temp_min
                if let firstWeather = weatherData.weather.first {
                    self.weatherCondition = firstWeather.description.capitalized
                }
            }
        }
    }
    
    func weatherEmoji() -> String {
        guard let condition = weatherCondition else { return "" }
        let conditionLowercased = condition.lowercased()
        
        let weatherEmojis: [String: String] = [
            "cloud": "☁️",
            "clear": "☀️",
            "rain": "🌧",
            "drizzle": "🌦️",
            "thunderstorm": "⛈️",
            "snow": "❄️",
            "fog": "🌫️",
            "tornado": "🌪️",
            "ash": "🌋"
        ]
        
        for (conditionKey, emoji) in weatherEmojis {
            if conditionLowercased.contains(conditionKey) {
                return emoji
            }
        }
        return "🌡️"
    }
    
    struct WeatherView_Previews: PreviewProvider {
        static var previews: some View {
            WeatherView()
        }
    }
}
