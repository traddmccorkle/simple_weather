//
//  WeatherMan.swift
//  simple weather
//
//  Created by Tradd McCorkle on 4/11/23.
//

import CoreLocation
import SwiftUI

class WeatherAPI {
    let apiKey: String //API key
    
    init() {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "WeatherAPIKey") as? String else {
            fatalError("API key not found in info.plist file")
        }
        self.apiKey = apiKey
    }
    let baseURL = "https://api.openweathermap.org/data/2.5/weather" //base URL
    
    func getWeatherDataForCurrentLocation(completion: @escaping (WeatherData?, Error?) -> ()) {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
        
        guard let location = locationManager.location else {
            completion(nil, NSError(domain: "LocationManagerError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to get user location."]))
            return
        }
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        let urlString = "\(baseURL)?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=imperial"
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherData.self, from: data)
                completion(weatherData, nil)
            } catch {
                completion(nil, error)
            }
        }
        
        task.resume()
    }
}

struct WeatherData: Codable {
    let main: Main
    let weather: [Weather]
    let name: String
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
}

struct Weather: Codable {
    let main: String
    let description: String
}

let weatherAPI = WeatherAPI()

func getCurrentWeather() {
    let weatherAPI = WeatherAPI()
    weatherAPI.getWeatherDataForCurrentLocation { (weatherData, error) in
        if let error = error {
            print("Error getting weather data: \(error.localizedDescription)")
        } else if let weatherData = weatherData {
            let temperature = weatherData.main.temp
            print("Temperature: \(temperature) °F")
        }
    }
}
