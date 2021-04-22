//
//  WeatherDetailViewController.swift
//  Lowe's-App
//
//  Created by Dinesh Danda on 4/22/21.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTempLabel: UILabel!
    @IBOutlet weak var weatherMainLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    var weatherDetailData:Weather?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let weatherDetailData = weatherDetailData{
            
            self.temperatureLabel.text = "\(convertTemp(temp: weatherDetailData.main.temp, from: .kelvin, to: .fahrenheit))"
            self.feelsLikeTempLabel.text = "Feels Like : \(convertTemp(temp: weatherDetailData.main.feelsLike, from: .kelvin, to: .fahrenheit))"
            self.weatherMainLabel.text = "\(weatherDetailData.weatherDetail[0].main)"
            self.weatherDescriptionLabel.text = "\(weatherDetailData.weatherDetail[0].description)"
        }
    }
}
