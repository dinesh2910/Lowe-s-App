//
//  WeatherService.swift
//  Lowe's-App
//
//  Created by Dinesh Danda on 4/22/21.
//

import Foundation

protocol WeatherService {
    func getWeatherData(forCityName cityName: String, _ responseHandler: @escaping (Result<Data, Error>) -> Void)

}

