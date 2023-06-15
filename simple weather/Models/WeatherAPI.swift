//
//  WeatherAPI.swift
//  simple weather
//
//  Created by Tradd McCorkle on 4/11/23.
//

import CoreLocation

struct WeatherData: Codable {
    let main: Main
    let weather: [Weather]
    let name: String
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
    let temp_min: Double
    let temp_max: Double
}

struct Weather: Codable {
    let main: String
    let description: String
}

class WeatherAPI: ObservableObject {
    let apiKey = "7958f83c1c9a9a3a23894a4b9fed97fe"
    let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    @Published var temperatureUnit = "imperial"
    
    func getWeatherDataForCurrentLocation(temperatureUnit: String, completion: @escaping (WeatherData?, Error?) -> ()) {
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
        
        let urlString = "\(baseURL)?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=\(temperatureUnit)"
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
