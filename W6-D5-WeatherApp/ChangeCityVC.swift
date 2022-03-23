//
//  ChangeCityVC.swift
//  W6-D5-WeatherApp
//
//  Created by Abdelrahman Nada on 14/03/2022.
//

import UIKit

class ChangeCityVC: UIViewController {
    
    @IBOutlet weak var changeCityLabelOutlet: UILabel!
    @IBOutlet weak var citySelectionPickerViewOutlet: UIPickerView!
    
    
    
    var citiesArr = [
        City(name: "Cairo", id: "360630"),
        City(name: "Alexandria", id: "361058"),
        City(name: "Aswan", id: "359792"),
        City(name: "Suez", id: "359796"),
        City(name: "Arish", id: "361546"),
        City(name: "Mersa Matruh", id: "352733")
         ]
    
    /*
     City => ID
     Cairo => 360630
     Alexandria => 361058
     Aswan => 359792
     Suez => 359796
     Arish => 361546
     Mersa Matruh => 352733
     */
    
    var selectedCity: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        citySelectionPickerViewOutlet.delegate = self
        citySelectionPickerViewOutlet.dataSource = self

    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        
        if let city = selectedCity {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cityChangedValue"), object: nil, userInfo: ["city": city])
            self.dismiss(animated: true, completion: nil)
        }
    }

}

extension ChangeCityVC: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return citiesArr.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return citiesArr[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        selectedCity = citiesArr[row]
        
    }
}
