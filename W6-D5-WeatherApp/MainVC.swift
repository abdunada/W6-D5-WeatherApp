//
//  ViewController.swift
//  W6-D5-WeatherApp
//
//  Created by Abdelrahman Nada on 14/03/2022.
//

import UIKit
import Alamofire

class MainVC: UIViewController {
    
    @IBOutlet weak var cityNameLabelOutlet: UILabel!
    @IBOutlet weak var editButtonOutlet: UIButton!
    @IBOutlet weak var loaderActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tempDegreeLabelOutlet: UILabel!
    @IBOutlet weak var pressDegreeLabelOutlet: UILabel!
    @IBOutlet weak var humiDegreeLabelOutlet: UILabel!
    
    /*
     City => ID
     Cairo => 360630
     Alexandria => 361058
     Aswan => 359792
     Suez => 359796
     Arish => 361546
     Mersa Matruh => 352733
     */
    var cityId = "360630"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editButtonOutlet.layer.cornerRadius = 12
        cityNameLabelOutlet.text = "Cairo"
        
        getCityWeatherInfo()
        
        NotificationCenter.default.addObserver(self, selector: #selector(cityChanged), name: NSNotification.Name(rawValue: "cityChangedValue"), object: nil)
        
    }
    
    @objc func cityChanged(notification: Notification) {
        
        if let city = notification.userInfo?["city"] as? City {
            
            cityNameLabelOutlet.text = city.name
            cityId = city.id
            
            getCityWeatherInfo()
        }
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        
        if  let page = storyboard?.instantiateViewController(withIdentifier: "ChangeCityVC") as? ChangeCityVC {
            page.modalPresentationStyle = .popover
            present(page, animated: true, completion: nil)
        }
    }
    
    func getCityWeatherInfo() {
        
        let parameter = ["id": cityId, "appid": "3e85fdf06c529df1a91a0f648ab5bed1"]
        // MARK: - Loader Activity Indicator
        //        loaderActivityIndicator.isHidden = false
        
        loaderActivityIndicator.hidesWhenStopped = false
        loaderActivityIndicator.startAnimating()
        
        AF.request("https://api.openweathermap.org/data/2.5/weather", parameters: parameter, encoder: URLEncodedFormParameterEncoder.default).responseJSON { response in
            if let result = response.value {
                let json = result as! NSDictionary
                let main = json["main"] as! NSDictionary
                // Temp
                var temp = main["temp"] as! Double
                temp = temp - 273.15
                //                temp = Double(round(temp * 1000) / 1000)
                temp = round(temp)
                // MARK: - Loader Activity Indicator
                self.loaderActivityIndicator.stopAnimating()
                self.loaderActivityIndicator.hidesWhenStopped = true
                //                self.loaderActivityIndicator.isHidden = true
                
                self.tempDegreeLabelOutlet.text = "\(temp)°"
                // pressure
                var press = main["pressure"] as! Int
                self.pressDegreeLabelOutlet.text = "\(press) hPa"
                //Humidity
                var humi = main["humidity"] as! Int
                self.humiDegreeLabelOutlet.text = "\(humi)%"
                
            }
        }
    }
    
}

