//
//  SaveDetailsViewController.swift
//  LocationList
//
//  Created by Ekin Barış Demir on 27.06.2021.
//

import UIKit

class SaveDetailsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
   
    @IBOutlet weak var locationDescTextView: UITextView!
    @IBOutlet weak var locationTypeTextField: UITextField!
    @IBOutlet weak var saveButton: CustomButton!
    var typeOfLocations = [String]()
    var type: String = "Restaurant"
    var userLocation = Location()
    var locationList = [Location]()
    var pickerView = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        locationTypeTextField.inputView = pickerView
        locationTypeTextField.backgroundColor = UIColor.viewBackgroundColor()
        
        locationList = StoreManager.shared.getLocation()
        typeOfLocations = ["Restaurant", "Bar", "Natural Place", "Historical Place"]
         
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeOfLocations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeOfLocations[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        locationTypeTextField.text = typeOfLocations[row]
        locationTypeTextField.resignFirstResponder()
    }
    
    @IBAction func saveLocation(_ sender: Any) {
        
        if let description = locationDescTextView.text {
            userLocation.definition = description
            userLocation.type = locationTypeTextField.text
            locationList.insert(userLocation, at: 0)
        }
        StoreManager.shared.saveLocation(data: locationList)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}


