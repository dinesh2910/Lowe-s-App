//
//  WeatherViewController.swift
//  Lowe's-App
//
//  Created by Dinesh Danda on 4/22/21.
//

import UIKit

class WeatherViewController: UIViewController {
    var searchedCityName: String = ""
    private var weatherViewModel: WeatherViewModel!
    @IBOutlet weak var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherViewModel = WeatherViewModel()
        setupTableView()
        bindViewsToViewModel()
        weatherViewModel.loadWeather(forCity: searchedCityName)
    }
    
     func bindViewsToViewModel() {
        weatherViewModel.weatherData.bind { wd in
            DispatchQueue.main.async {
                if self.weatherViewModel.isDataAvailable == false {
                    self.showAlert(alertText: Constant.alert, alertMessage: Constant.noResultsFound)
                }
                self.tableView.reloadData()
            }
        }
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constant.cell)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.tableFooterView = UIView()
    }
}


extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let wd = weatherViewModel.weatherDataModel {
            return wd.list.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: Constant.cell)
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
        let cellData = weatherViewModel.weatherDataModel!.list[indexPath.row]
        cell.textLabel?.text = " \(cellData.weatherDetail[0].main)"
        cell.textLabel?.textColor = .black
        cell.detailTextLabel?.text = "Temp : \(convertTemp(temp: cellData.main.temp, from: .kelvin, to: .fahrenheit))"
        cell.detailTextLabel?.textColor = .black
        cell.selectionStyle = .none
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
}

extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellData = weatherViewModel.weatherDataModel!.list[indexPath.row]
        let storyboard = UIStoryboard(name: Constant.main, bundle: nil)
        let weatherViewController = storyboard.instantiateViewController(withIdentifier: Constant.weatherDetailViewController) as! WeatherDetailViewController
        weatherViewController.weatherDetailData = cellData
        let backItem = UIBarButtonItem()
        backItem.title = searchedCityName
        navigationItem.backBarButtonItem = backItem
        navigationController?.pushViewController(weatherViewController, animated: true)
    }
}
