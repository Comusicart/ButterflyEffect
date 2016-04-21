//
//  ViewController.swift
//  ButterflyEffect
//
//  Created by comusicart on 4/22/16.
//  Copyright © 2016 Comusicart. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    let genderOption = ["male", "female"]
    let yearOption = Array(1...100)
    let monthOption = Array(1...11)
    
    @IBOutlet var yearField: UITextField!
    @IBOutlet var monthField: UITextField!
    @IBOutlet var genderField: UITextField!
    @IBOutlet var indicator: UILabel!
    
    @IBAction func enter() {
        indicator.text = genderField.text
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let genderPickerView = UIPickerView()
        genderPickerView.delegate=self
        genderPickerView.tag = 1
        genderField.inputView = genderPickerView
        
        let yearPickerView = UIPickerView()
        yearPickerView.delegate=self
        yearPickerView.tag  = 2
        yearField.inputView = yearPickerView
        
        let monthPickerView = UIPickerView()
        monthPickerView.delegate=self
        monthPickerView.tag = 3
        monthField.inputView = monthPickerView
        
    
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var returnValue = 0
        
        switch pickerView.tag {
        case 1:
            returnValue = genderOption.count
        case 2:
            returnValue = yearOption.count
        case 3:
            returnValue = monthOption.count
        default:
            returnValue = 0
        }
        
        return returnValue
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView.tag {
        case 1:
            return genderOption[row]
        case 2:
            return String(yearOption[row])
        case 3:
            return String(monthOption[row])
        default:
            return nil
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            genderField.text = genderOption[row]
        case 2:
            yearField.text = String(yearOption[row])
        case 3:
            monthField.text = String(monthOption[row])
        default:
            print("tag not found")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

