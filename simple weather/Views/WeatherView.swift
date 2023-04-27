import SwiftUI
import CoreLocation

struct WeatherView: View {
    let weatherAPI = WeatherAPI()
    @EnvironmentObject var globalVariables: GlobalVariables
    
    @State private var currentLocation: String?
    @State private var temperature: Double = 0
    @State private var highTemperature: Double = 0
    @State private var lowTemperature: Double = 0
    @State private var weatherCondition: String?

    //Body
    var body: some View {
        NavigationStack {
            VStack {
                if temperature == 0 {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    HStack {
                        Image(systemName: "location.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("\(currentLocation ?? "")")
                            .font(.system(size: 25.0, design: .rounded))
                    }
                    Text(String(format: "%g", round(temperature)))
                        .font(.system(size: 100.0, design: .rounded))
                    HStack {
                        Text("H: \(String(format: "%g", round(highTemperature)))°")
                            .font(.system(size: 25.0, design: .rounded))
                        Text("L: \(String(format: "%g", round(lowTemperature)))°")
                            .font(.system(size: 25.0, design: .rounded))
                    }
                    Text("\(weatherCondition ?? "")")
                        .font(.system(size: 20.0, design: .rounded))
                }
            }
            .onAppear() {
                getCurrentWeather()
                print("Fetching weather.")
            }
        }
    }

    //Function that gets the current weather using WeatherAPI
    func getCurrentWeather() {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
        
        guard locationManager.location != nil else {
            print("Unable to get user location.")
            return
        } //Checks to see if currentLocation is nil
        
        weatherAPI.getWeatherDataForCurrentLocation() { (weatherData, error) in
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

    struct WeatherView_Previews: PreviewProvider {
        static var previews: some View {
            WeatherView()
        }
    }
}
