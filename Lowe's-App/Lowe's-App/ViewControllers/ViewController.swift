//
//  ViewController.swift
//  Lowe's-App
//
//  Created by Dinesh Danda on 4/22/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var cityNameSearchTF: UITextField!
    @IBOutlet weak var seperatorLine: UIView!
    @IBOutlet weak var lookupButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        configureKeyboardToolbar()
        setupButtonInterface()
    }
    
    func setupButtonInterface() {
        lookupButton.layer.cornerRadius = 5.0
        lookupButton.layer.borderWidth = 1.0
       
    }
    
    
    private func configureKeyboardToolbar() {
        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.barStyle = .default
        let item1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let item2 = UIBarButtonItem(title: Constant.done, style: .plain, target: self, action: #selector(doneWithKeyboard))
        toolbar.setItems([item1,item2], animated: false)
        toolbar.isUserInteractionEnabled = true
        toolbar.sizeToFit()
        cityNameSearchTF.inputAccessoryView = toolbar
    }
    
    @objc private func doneWithKeyboard() {
        cityNameSearchTF.resignFirstResponder()
    }
    


    @IBAction func didTapOnLookupBtn(_ sender: UIButton) {
        
        if let cityNameSearchTextField = cityNameSearchTF.text, cityNameSearchTextField.isEmpty {
            showAlert(alertText: Constant.alert, alertMessage: Constant.pleaseEnterCityName)
            return
        }
        cityNameSearchTF.resignFirstResponder()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let storyboard = UIStoryboard(name: Constant.main, bundle: nil)
        let weatherViewController = storyboard.instantiateViewController(withIdentifier: Constant.weatherViewController) as! WeatherViewController
        weatherViewController.searchedCityName = cityNameSearchTF.text!
        let backItem = UIBarButtonItem()
        backItem.title = cityNameSearchTF.text!
        navigationItem.backBarButtonItem = backItem
        navigationController?.pushViewController(weatherViewController, animated: true)
    }
}


extension UIViewController {
    func showAlert(alertText : String, alertMessage : String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Constant.ok, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

