//
//  ViewController.swift
//  Pruebas TextField
//
//  Created by Pablo Guardiola on 18/08/16.
//  Copyright © 2016 Pablo Guardiola. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var myTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        print("OK")
        
        return false
    }

    @IBAction func test(sender: UITextField) {
        print(sender.text!)
    }

}

