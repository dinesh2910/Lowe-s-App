//
//  OpenWeatherService.swift
//  Lowe's-App
//
//  Created by Dinesh Danda on 4/22/21.
//

import Foundation

class OpenWeatherService: WeatherService {
    static var shared = OpenWeatherService()
    private init() { }
    
    func getWeatherData(forCityName cityName: String, _ responseHandler: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: "\(Constant.baseURLString)\(cityName)&appid=\(Constant.apiKey)&cnt=\(Constant.fiveDaysForecast)") else{
            responseHandler(.failure(NSError(domain: "Error url", code: 0, userInfo: [NSLocalizedDescriptionKey : "No valid data"])))
            return
        }
        getWeatherData(withQueryUrl: url, responseHandler)
            
        
    }
    
    
    private func getWeatherData(withQueryUrl queryUrl: URL, _ responseHandler: @escaping (Result<Data, Error>) -> Void) {
        let weatherTask = URLSession.shared.dataTask(with: queryUrl) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                responseHandler(.success(data!))
                return

            }
            responseHandler(.failure(error ?? NSError(domain: "Network Error", code: 0, userInfo: [NSLocalizedDescriptionKey : "Network call unsuccessful to fetch weather data"])))
        }
        weatherTask.resume()
    }

}
