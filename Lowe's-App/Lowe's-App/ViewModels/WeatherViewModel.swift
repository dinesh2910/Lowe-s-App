//
//  WeatherViewModel.swift
//  Lowe's-App
//
//  Created by Dinesh Danda on 4/22/21.
//

import Foundation

func convertTemp(temp: Double, from inputTempType: UnitTemperature, to outputTempType: UnitTemperature) -> String {
  let mf = MeasurementFormatter()
  mf.numberFormatter.maximumFractionDigits = 0
  mf.unitOptions = .providedUnit
  let input = Measurement(value: temp, unit: inputTempType)
  let output = input.converted(to: outputTempType)
  return mf.string(from: output)
}

class Box<T> {
    typealias Listener = (T?) -> Void
    
    private var listener: Listener?
    
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}

class WeatherViewModel {
    
    var weatherData = Box<WeatherDataModel>()
    var weatherService: WeatherService
    var weatherDataModel: WeatherDataModel?
    var isDataAvailable = true

    init(){
        self.weatherService = OpenWeatherService.shared

    }
    
    func loadWeather(forCity cityName: String) {        
        getWeatherData(forCity: cityName) { isSuccess in
            if isSuccess {
                self.isDataAvailable = true
                self.updateFromModel()
            }
            else {
                self.isDataAvailable = false
                self.updateToDataUnavailable()
            }
        }
    }
    
    func getWeatherData(forCity cityName: String, _ completionHandler: @escaping (Bool) -> Void) {
        weatherService.getWeatherData(forCityName: cityName) { result in
            switch result {
            case .success(let weatherData):
                self.parseAndRetrieveWeatherData(from: weatherData, completionHandler)
                
            case .failure(_):
                completionHandler(false)
            }
        }
    }
    
    private func parseAndRetrieveWeatherData(from jsonDict: Data, _ completion: @escaping (Bool) -> Void) {
            do {
                let weather = try JSONDecoder().decode(WeatherDataModel.self, from: jsonDict)
                print(weather)
                self.weatherDataModel = weather

            } catch {
                // Inspect any thrown errors here.
                print(error)

            }
            completion(true)
        }
    
    
    private func updateFromModel() {
        if let wd = weatherDataModel{
            weatherData.value = wd
        }
    }
    
    private func updateToDataUnavailable() {
        weatherData.value = nil
    }
}
