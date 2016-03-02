//
//  ViewController.swift
//  Weather
//
//  Created by Lamb on 15/10/21.
//  Copyright © 2015年 Lamb. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var location: UILabel!
    @IBOutlet var icon: UIImageView!
    @IBOutlet var temperature: UILabel!
    let locationManager:CLLocationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        if(ios8()){
//            locationManager.requestAlwaysAuthorization()
//        }
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
        print("startUpdatingLocation")
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Current location: \(location)")
            //locationManager.stopUpdatingLocation()
            //print("stopUpdatingLocation")
            updateWeather(location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error finding location: \(error.localizedDescription)")
    }
    
    func updateWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let manager = AFHTTPRequestOperationManager()
        let url = "http://api.openweathermap.org/data/2.5/weather"
        let parameters = ["lat": latitude, "lon": longitude, "appid": "817873edd727da52e7e7678f9fac240f"]
        manager.GET(url, parameters: parameters, success: { (operation: AFHTTPRequestOperation, responseObject: AnyObject) -> Void in
                //print("JSON:" + responseObject.description)
                self.updateUI(responseObject as! NSDictionary)
            }, failure: { (operation: AFHTTPRequestOperation , error: NSError) -> Void in
                print("Error:" + error.description)
        })
    }
    
    func updateUI(data: NSDictionary!) {
        if let temp = data["main"]?["temp"] as? Double {
            self.temperature.text = "\(round(temp - 273.15))°C"
        }
        if let name = data["name"] as? String {
            self.location.text = "\(name)"
        }
        if let icon = data["weather"]?[0]?["icon"] as? String {
            let iconUrl = "http://openweathermap.org/img/w/\(icon).png"
            print(iconUrl)
            self.icon.image = UIImage(data: NSData(contentsOfURL: NSURL(string: iconUrl)!)!)
        }
    }
    
    func ios8() -> Bool {
        return UIDevice.currentDevice().systemVersion == "8.0"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

