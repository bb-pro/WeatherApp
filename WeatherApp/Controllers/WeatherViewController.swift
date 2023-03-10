//
//  ViewController.swift
//  WeatherApp
//
//  Created by Bektemur on 06/02/23.
//

import UIKit
import CoreLocation


final class WeatherViewController: UIViewController {
    //MARK: - IB Outlets
    
    @IBOutlet var celsiuslabel: UILabel!
    @IBOutlet var celciusCircle: UILabel!
    
    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBOutlet var conditionImageView: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var weatherDescription: UILabel!
    
    @IBOutlet var bitcoinButton: UIButton!
    
    
    var tempString: String = ""

    let locationManager = CLLocationManager()
    
    var weatherManager = WeatherManager()
    
    var weatherBackgroundIsOn = false
    
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
       
        hideElements()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
    // Метод для скрытия клавиатуры тапом по экрану
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    //MARK: - IB Actions
    @IBAction func getLocationPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            self.bitcoinButton.frame.origin.y -= 100
        })
        hideElements()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
    
    @IBAction func bitcoinButtonPressed(_ sender: UIButton) {
    }
    
    
    //MARK: - Private Methods
    private func animateScreen(start: Bool) {
        if start {
            UIView.animate(withDuration: 5, animations: {
                self.conditionImageView.image = UIImage(systemName: "magnifyingglass")
                self.weatherDescription.text = "Подключение..."
                self.conditionImageView.alpha = 0.8
                self.celciusCircle.isHidden = false
                self.celsiuslabel.isHidden = false
                self.weatherDescription.isHidden = false
                self.temperatureLabel.isHidden = false
                self.conditionImageView.isHidden = false
                self.cityLabel.isHidden = false
            })
        }
    }
    private func hideElements() {
        UIView.animate(withDuration: 5, animations: {
            self.conditionImageView.isHidden = true
            self.temperatureLabel.isHidden = true
            self.celsiuslabel.isHidden = true
            self.celciusCircle.isHidden = true
            self.weatherDescription.isHidden = true
            self.cityLabel.isHidden = true
        })
    }
}


//MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            UIView.animate(withDuration: 0.2, animations: {
                self.bitcoinButton.frame.origin.y -= 100
            })
            hideElements()
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            animateScreen(start: true)
            weatherManager.fetchWeather(cityName: city)
        }
    }
}

//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManage: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            self.weatherDescription.text = weather.description
            self.tempString = weather.temperatureString
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            animateScreen(start: true)
            weatherManager.fetchWeatherWithCoordinate(lat: lat, lon: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
}

