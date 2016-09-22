//
//  ViewController.swift
//  MakeWeather-starter
//
//  Created by Nikolas Burk on 19/09/16.
//  Copyright © 2016 Nikolas Burk. All rights reserved.
//

import UIKit
import YWeatherAPI

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
  override func viewDidLoad() {
    weather()
    futureWeather()
    textField.delegate = self
    super.viewDidLoad()

//    YWeatherAPI.sharedManager().todaysForecast(forLocation: "San Francisco",
//                                               success: { (result: [AnyHashable: Any]?) in
//                                                print(result)
//                                                print(result?["lowTemperatureForDay"])
//                                                print(result?["highTemperatureForDay"])
//                                                print(result?["shortDescription"])
//      },
//                                               failure: { (response: Any?, error: Error?) in
//                                                print(error)
//      }
//    )
    
    
    self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard)))
  }
    func dismissKeyboard() {
        textField.resignFirstResponder()
        weather()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        weather()
        return true
    }
    
    func futureWeather() {
        YWeatherAPI.sharedManager().fiveDayForecast(forLocation: "San Francisco",
                                                    success: { (result: [AnyHashable: Any]?) in
                                                        print(result)
                                                        
            },
                                                    failure: { (response: Any?, error: Error?) in
                                                        print(error)
            }
        )
    }
    
    func weather() {
        YWeatherAPI.sharedManager().todaysForecast(forLocation: "San Francisco",
                                                   success: { (result: [AnyHashable: Any]?) in
                                                    print(result)
                                                    let lowTemp = result?["lowTemperatureForDay"]
                                                    let highTemp = result?["highTemperatureForDay"]
                                                    let description = result?["shortDescription"]
                                                    print(result?["kYWADateComponents"]!)
                                                    
                                                    self.tempLabel.text = "\(lowTemp!)° / \(highTemp!)°"
                                                    self.weatherLabel.text = String(describing: description!)
            },
                                                   failure: { (response: Any?, error: Error?) in
                                                    print(error)
            }
        )
    }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
    

}

