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
        
        let testObject = PQL(tableName: "TestTable")
        
        testObject.fields["Foo"] = "Bar"
        
        testObject.save()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

