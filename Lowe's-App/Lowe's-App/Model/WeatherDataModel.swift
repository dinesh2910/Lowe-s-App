//
//  WeatherDataModel.swift
//  Lowe's-App
//
//  Created by Dinesh Danda on 4/22/21.
//

import Foundation

// MARK: - WeatherDataModel
struct WeatherDataModel:Codable{
    var list: [Weather]
}

struct Weather: Codable {
    let weatherDetail: [WeatherDetail]
    let main: Main
    
    enum CodingKeys: String, CodingKey {

        case weatherDetail = "weather"
        case main = "main"
    }
}

struct Main: Codable {
    let temp: Double
    var feelsLike: Double
    let pressure: Double
    let humidity: Double
    
    enum CodingKeys: String, CodingKey {
        case feelsLike = "feels_like"
        case temp
        case pressure
        case humidity
    }
}


struct WeatherDetail: Codable {
    let main: String
    let description: String
}
