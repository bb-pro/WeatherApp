//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by Bektemur Mamashayev on 13/02/23.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    var weatherScreen = UIViewController()
    var weatherBgIsOn = false
    var btcBgIsOn = false
    
    @IBOutlet var weatherBackgroundImage: UISwitch!
    @IBOutlet var bitcoinBackgroundImage: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    @IBAction func weatherSwitchPressed(_ sender: UISwitch) {
        
        if sender.isOn {
            let app = UIApplication.shared
            app.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        } else if !sender.isOn {
            let app = UIApplication.shared
            app.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        }
    }
    @IBAction func logOut() {
        dismiss(animated: true)
    }
}
