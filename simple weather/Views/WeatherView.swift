import SwiftUI
import CoreLocation

struct WeatherView: View {
    let weatherAPI = WeatherAPI()
    
    @AppStorage("temperatureUnit") private var selectedUnit: String = TemperatureUnit.fahrenheit.rawValue
    
    @State private var currentLocation: String = ""
    @State private var temperature: String = ""
    @State private var highTemperature: String = ""
    @State private var lowTemperature: String = ""
    @State private var weatherCondition: String = ""
    
    init(temperature: String = "", highTemperature: String = "", lowTemperature: String = "", currentLocation: String = "", weatherCondition: String = "") {
        _currentLocation = State(initialValue: currentLocation)
        _temperature = State(initialValue: temperature)
        _highTemperature = State(initialValue: highTemperature)
        _lowTemperature = State(initialValue: lowTemperature)
        _weatherCondition = State(initialValue: weatherCondition)
    }
    // Body
    var body: some View {
        VStack {
            if temperature.isEmpty {
                //Displays progress circle until weather updates
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                HStack {
                    Image(systemName: "location.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("\(currentLocation)")
                        .font(.system(size: 25.0, design: .rounded))
                }
                Text("\(temperature)°")
                    .font(.system(size: 100.0, design: .rounded))
                HStack {
                    Text("H: \(highTemperature)°")
                        .font(.system(size: 25.0, design: .rounded))
                    Text("L: \(lowTemperature)°")
                        .font(.system(size: 25.0, design: .rounded))
                }
                Text("\(weatherCondition)")
                    .font(.system(size: 20.0, design: .rounded))
            }
        }
        .onAppear() { //Updates weather when this view appears
            getCurrentWeather()
        }
    }
    
    func apiUnitFormat(from temperatureUnit: String) -> String {
        switch temperatureUnit {
        case TemperatureUnit.fahrenheit.rawValue:
            return "imperial"
        case TemperatureUnit.celsius.rawValue:
            return "metric"
        default:
            return "imperial"
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
        } //Checks to see if currentLocation is nil
        let apiUnit = apiUnitFormat(from: selectedUnit)
        weatherAPI.getWeatherDataForCurrentLocation(unit: apiUnit) { (weatherData, error) in
                if let error = error {
                    print("Error getting weather data: \(error.localizedDescription)")
                } else if let weatherData = weatherData {
                    let temperatureInSelectedUnit = Int(weatherData.main.temp)
                    self.temperature = String(temperatureInSelectedUnit)
                    self.currentLocation = weatherData.name
                    self.highTemperature = String(Int(weatherData.main.temp_max))
                    self.lowTemperature = String(Int(weatherData.main.temp_min))
                    if let firstWeather = weatherData.weather.first {
                        self.weatherCondition = firstWeather.description.capitalized
                    }
                }
            }
        }
        
        struct WeatherView_Previews: PreviewProvider {
            static var previews: some View {
                WeatherView(temperature: "69", highTemperature: "99", lowTemperature: "32", currentLocation: "Sample City", weatherCondition: "Thunderstorm")
            }
        }
}
