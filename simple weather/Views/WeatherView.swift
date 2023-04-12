import SwiftUI
import CoreLocation

struct WeatherView: View {
    let weatherAPI = WeatherAPI() //Variable that calls the class WeatherAPI()
    //Variables
    @State private var currentLocation: String?
    @State private var temperature: String?
    @State private var highTemperature: String?
    @State private var lowTemperature: String?
    @State private var weatherCondition: String?
    @State private var temperatureUnitImperial = UserDefaults.standard.bool(forKey: "temperatureUnitImperial")

    //Body
    var body: some View {
        NavigationStack {
            VStack {
                if temperature == nil {
                    //Displays progress circle until weather updates
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
                    Text("\(temperature ?? "")°")
                        .font(.system(size: 100.0, design: .rounded))
                    HStack {
                        Text("H: \(highTemperature ?? "")°")
                            .font(.system(size: 25.0, design: .rounded))
                        Text("L: \(lowTemperature ?? "")°")
                            .font(.system(size: 25.0, design: .rounded))
                    }
                    Text("\(weatherCondition ?? "")")
                        .font(.system(size: 20.0, design: .rounded))
                }
            }
            .onAppear() { //Updates weather when this view appears
                getCurrentWeather()
            }
        }
        .navigationBarItems(
            trailing:
                Menu {
                    Button(action: {
                        self.temperatureUnitImperial = false
                        UserDefaults.standard.set(self.temperatureUnitImperial, forKey: "temperatureUnitImperial")
                        getCurrentWeather()//Updates weather when buton is pressed
                    }) {
                        HStack {
                            if temperatureUnitImperial == false {
                                Text("✓ Celsius °C")
                            } else {
                                Text("Celsius °C")
                            }
                        }
                    }
                    Button(action: {
                        self.temperatureUnitImperial = true
                        UserDefaults.standard.set(self.temperatureUnitImperial, forKey: "temperatureUnitImperial")
                        getCurrentWeather()//Updates weather when buton is pressed
                    }) {
                        HStack {
                            if temperatureUnitImperial == true {
                                Text("✓ Fahrenheit °F")
                            } else {
                                Text("Fahrenheit °F")
                            }
                        }
                    }
                }
                label: {
                    Image(systemName: "ellipsis.circle")
                        .font(.system(size: 20))
                }
        )
    }

    //Function that converts temperature from Imperial to Metric if needed
    private func convertTemperatureIfNeeded(_ temperature: Double) -> Int {
        if temperatureUnitImperial {
            return Int(temperature)
        } else {
            let celsius = (temperature - 32) * (5.0 / 9.0) // Use floating-point division here
            return Int(celsius)
        }
    }

    //Function that gets the current weather using WeatherAPI
    func getCurrentWeather(units: String = "imperial") { // Add a units parameter with a default value
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
       

        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
        
        guard locationManager.location != nil else {
            print("Unable to get user location.")
            return
        } //Checks to see if currentLocation is nil
        weatherAPI.getWeatherDataForCurrentLocation(units: units) { (weatherData, error) in
            if let error = error {
                print("Error getting weather data: \(error.localizedDescription)")
            } else if let weatherData = weatherData {
                let temperatureInSelectedUnit = convertTemperatureIfNeeded(weatherData.main.temp)
                self.temperature = String(temperatureInSelectedUnit)
                self.currentLocation = weatherData.name
                self.highTemperature = String(convertTemperatureIfNeeded(weatherData.main.temp_max))
                self.lowTemperature = String(convertTemperatureIfNeeded(weatherData.main.temp_min))
                if let firstWeather = weatherData.weather.first {
                    self.weatherCondition = firstWeather.description.capitalized
                }
            }
        }
    }
    //Preview provider
    struct WeatherView_Previews: PreviewProvider {
        static var previews: some View {
            WeatherView()
        }
    }
}
