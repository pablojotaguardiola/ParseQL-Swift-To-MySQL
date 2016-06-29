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
        
        // MARK: CREATE
        let saveTestObject = PQL(tableName: "TestTable")
        
        saveTestObject.fields["Foo"] = "Bar"
        
        saveTestObject.save()
        // ------------
        
        
        // MARK: UPDATE
        let updateTestObject = PQL(tableName: "TestTable")
        
        updateTestObject.whereKey("Foo", equalTo: "Bar")
        
        updateTestObject.setKey("Foo", value: "Baaar")
        
        updateTestObject.update()
        // ------------
        
        
        // MARK: DELETE
        let deleteTestObject = PQL(tableName: "TestTable")
        
        deleteTestObject.whereKey("Foo", equalTo: "Baaar")
        
        deleteTestObject.delete()
        // ------------
        
        
        // MARK: CREATE WITH BLOCK
        let saveBlockTestObject = PQL(tableName: "TestTable")
        
        saveBlockTestObject.fields["Foo"] = "Bar"
        
        saveBlockTestObject.saveWithBlock {(result: String) in
            //Save success!!
            print(result) //"OK" by now...
        }
        // ------------
        
        
        // MARK: UPDATE WITH BLOCK
        let updateBlockTestObject = PQL(tableName: "TestTable")
        
        updateBlockTestObject.whereKey("Foo", equalTo: "Bar")
        
        updateBlockTestObject.setKey("Foo", value: "Baaar")
        
        updateBlockTestObject.updateWithBlock {(affectedRows: [[String: AnyObject]]) in
            //Update success
            if affectedRows.count > 0 {
                print(affectedRows[0]["id"]) //"0"
            }
        }
        // ------------
        
        
        // MARK: DELETE WITH BLOCK
        let deleteBlockTestObject = PQL(tableName: "TestTable")
        
        deleteBlockTestObject.whereKey("Foo", equalTo: "Baaar")
        
        deleteBlockTestObject.deleteWithBlock {(numOfAffectedRows: Int) in
            //Delete success!!
            print(numOfAffectedRows) // "1"
        }
        // ------------
        
        // MARK: GET
        let getBlockTestObject = PQL(tableName: "TestTable")
        
        getBlockTestObject.orderByAsc = "id"
        getBlockTestObject.orderByDesc = "id"
        
        getBlockTestObject.whereKey("Foo", equalTo: "Bar")
        
        getBlockTestObject.get {(results: [[String: AnyObject]]) in
            //Here come the data!!
            for row in results {
                print(row["Foo"]) //"Bar"
            }
        }
        // ------------
<<<<<<< HEAD
=======
        
        
>>>>>>> origin/master
    }
}

