//
//  ViewController.swift
//  ButterflyEffect
//
//  Created by comusicart on 4/22/16.
//  Copyright © 2016 Comusicart. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        genderField.delegate=self
        yearField.delegate=self
        monthField.delegate=self
        // Do any additional setup after loading the view, typically from a nib.
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
    
    @IBOutlet var genderField: UITextField!
    @IBOutlet var yearField: UITextField!
    @IBOutlet var monthField: UITextField!

    @IBAction func enterButton(sender: AnyObject) {
        var name: String
        
        if (genderField.text != nil) {
            name = genderField.text!
        }
    }
    
}

