//
//  ViewController.swift
//  MakeWeather-starter
//
//  Created by Nikolas Burk on 19/09/16.
//  Copyright © 2016 Nikolas Burk. All rights reserved.
//

import UIKit
import YWeatherAPI
import SwiftyJSON

class ViewController: UIViewController, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
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
//                                                        print(result)
                                                        print(result?["index"])
                                                        let json = JSON(result?["index"])
                                                        print(json[0]["highTemperatureForDay"].stringValue)
                                                        print(json[0]["lowTemperatureForDay"].stringValue)
                                                        print(json[0]["shortDescription"].stringValue)
                                                        
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
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let screenWidth = collectionView.bounds.width
        let screenHeight = collectionView.bounds.height
        let square = CGSize.init(width: (screenWidth/3)-2, height: screenHeight)
        
        return square
    }
    
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        
        YWeatherAPI.sharedManager().fiveDayForecast(forLocation: "San Francisco",
                                                    success: { (result: [AnyHashable: Any]?) in
                                                        let json = JSON(result?["index"])
                                                        let highTemp = json[indexPath.row]["highTemperatureForDay"].stringValue
                                                        let lowTemp = json[indexPath.row]["lowTemperatureForDay"].stringValue
                                                        let description = json[indexPath.row]["shortDescription"].stringValue
                                                        var date = json[indexPath.row]["kYWADateComponents"].stringValue
                                                        
                                                        cell.cellWeatherLabel.text = description
                                                        cell.cellDateLabel.text = ""
                                                        cell.cellTempLabel.text = "\(highTemp)° / \(lowTemp)°"
                                                        
                                                        
            },
                                                    failure: { (response: Any?, error: Error?) in
                                                        print(error)
            }
        )
        
        // Configure the cell
        
        
        
        return cell
    }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
    

}

