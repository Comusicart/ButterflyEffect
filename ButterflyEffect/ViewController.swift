//
//  ViewController.swift
//  ButterflyEffect
//
//  Created by comusicart on 4/22/16.
//  Copyright © 2016 Comusicart. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
//import Social

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    let genderOption = ["male", "female"]
    let yearOption = Array(1...100)
    let monthOption = Array(1...11)
    
    var JSONInput = ""
    
    @IBOutlet var yearField: UITextField!
    @IBOutlet var monthField: UITextField!
    @IBOutlet var genderField: UITextField!
    @IBOutlet var indicator: UILabel!
    
    func parseJSONResults() -> [String: AnyObject]? {
        let data = JSONInput.dataUsingEncoding(NSUTF8StringEncoding)
        
        do {
            if let data = data,
                json = try NSJSONSerialization.JSONObjectWithData(data, options:[]) as? [String: AnyObject] {
                return json
            } else {
                print("No Data :/")
            }
        } catch {
            print("Error, Could not parse the JSON request")
        }
        
        return nil
    }
    
    @IBAction func enter() {
        
        let gender = genderField.text!
        let year = yearField.text!
        let month = monthField.text!
        
        let URL: String = "http://api.population.io:80/1.0/life-expectancy/remaining/\(gender)/Rep%20of%20Korea/2016-04-22/\(year)y\(month)m/"
        
        Alamofire.request(.GET, URL).responseJSON { response in
                guard response.result.error == nil else {
               
                    print("error calling GET")
                    print(response.result.error!)
                    return
                }
                
                if let value = response.result.value {
                  
                    let responseFromServer = JSON(value)
                  
                    print("The response is: " + responseFromServer.description)
                    if let life_remain = responseFromServer["remaining_life_expectancy"].double {
                        print("remaining_life_expectancy: \(life_remain)")
                        self.indicator.text = "남은 인생 : \(life_remain)%"
                    } else {
                        print("error parsing ")
                    }
                }
        }
    }

//    @IBAction func survivedButton(sender: AnyObject) {
//        
//        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
//            let fbShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
//            
//            self.presentViewController(fbShare, animated: true, completion: nil)
//            
//        } else {
//            let alert = UIAlertController(title: "로그인", message: "페이스북 어플리케이션에서 먼저 로그인하세요", preferredStyle: UIAlertControllerStyle.Alert)
//            
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//            self.presentViewController(alert, animated: true, completion: nil)
//        }
//    }
    
    
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

