//
//  ViewController.swift
//  ParseQL
//
//  Created by Pablo Guardiola on 28/06/16.
//  Copyright © 2016 Pablo Guardiola. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let getTestObject = PQL(tableName: "TestTable")
        
        getTestObject.whereKey("Foo", equalTo: "Baar")
        
        getTestObject.delete()
    }
}

