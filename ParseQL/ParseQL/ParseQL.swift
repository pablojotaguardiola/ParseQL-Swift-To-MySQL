//
//  SQLEngine.swift
//  AppBuilder
//
//  Created by Pablo Guardiola on 22/04/16.
//  Copyright © 2016 Pablo Guardiola. All rights reserved.
//

import Foundation

public class PQL {
    
    let BASE_URL: String = "http://parseql.com"
    
    //TABLE
    var tableName: String!
    
    //COLUMNS
    var fields: [String: AnyObject]!
    
    //BASIC CONDITION
    private var whereKey: [String: AnyObject]!
    private var setKey: [String: AnyObject]!
    var orderByAsc: String!
    var orderByDesc: String!
    
    //LIMIT
    var limit = 10
    var skip = 0
    
    //GEOLOCATION
    var geoDistance: Float!
    var latitude: Double!
    var longitude: Double!
    
    //TASK
    var task: NSURLSessionUploadTask!
    
    //INIT
    public init(tableName: String) {
        self.tableName = tableName
        fields = [String: AnyObject]()
        whereKey = [String: AnyObject]()
        setKey = [String: AnyObject]()
    }
    
    //SAVE
    public func save() {
        if (fields.count > 0) {
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            config.HTTPAdditionalHeaders = ["Accept": "application/json",
                                            "Content-Type": "application/json"
                                            ]
            
            let session = NSURLSession(configuration: config)
            
            let request = NSMutableURLRequest(URL: NSURL(string: BASE_URL + "/parseql/index.php/parseQLController/saveObject")!)
            request.HTTPMethod = "POST"
            
            let valuesToSend = ["tableName": tableName, "fieldsDictionary": fields]
            
            
            do {
                let data = try NSJSONSerialization.dataWithJSONObject(valuesToSend, options:NSJSONWritingOptions.PrettyPrinted)
                
                if task != nil {
                    task.cancel()
                }
                
                task = session.uploadTaskWithRequest(request, fromData: data, completionHandler: {data, response, error in
                    
                    if error == nil {
                        //CORRECT
                        print((NSString(data: data!, encoding: NSUTF8StringEncoding)! as String))
                    }
                    else {
                        print("error")
                    }
                    
                })
                task.resume()
                
            } catch {
                print("Oups error \(error)")
            }
        }
    }
    
    //SAVE WITH BLOCK
    public func saveWithBlock(completion: (String) -> ()) {
        if (fields.count > 0) {
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            config.HTTPAdditionalHeaders = ["Accept": "application/json",
                                            "Content-Type": "application/json"
            ]
            
            let session = NSURLSession(configuration: config)
            
            let request = NSMutableURLRequest(URL: NSURL(string: BASE_URL + "/parseql/index.php/parseQLController/saveObject")!)
            request.HTTPMethod = "POST"
            
            let valuesToSend = ["tableName": tableName, "fieldsDictionary": fields]
            
            do {
                let data = try NSJSONSerialization.dataWithJSONObject(valuesToSend, options:NSJSONWritingOptions.PrettyPrinted)
                
                if task != nil {
                    task.cancel()
                }
                
                task = session.uploadTaskWithRequest(request, fromData: data, completionHandler: {data, response, error in
                    
                    
                    if error == nil {
                        let responseDictionary = self.convertStringToDictionary((NSString(data: data!, encoding: NSUTF8StringEncoding)! as String) as String)
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            completion(responseDictionary["Resp"] as! String)
                        }
                    }
                    else {
                        print(error)
                    }
                    
                })
                task.resume()
                
            } catch {
                
            }
        }
    }
    
    //GET
    public func get(completion: ([[String: AnyObject]]) -> ()) {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.HTTPAdditionalHeaders = ["Accept": "application/json",
                                        "Content-Type": "application/json"
        ]
        
        let session = NSURLSession(configuration: config)
        
        let request = NSMutableURLRequest(URL: NSURL(string: BASE_URL + "/parseql/index.php/parseQLController/getObject")!)
        request.HTTPMethod = "POST"
        
        var valuesToSend: [String: AnyObject] = ["tableName": tableName, "whereDictionary": whereKey, "limit": limit, "skip": skip]
        
        if orderByAsc != nil {
            valuesToSend["orderByAsc"] = orderByAsc
        }
        else if orderByDesc != nil {
            valuesToSend["orderByDesc"] = orderByDesc
        }
        
        if geoDistance != nil && latitude != nil && longitude != nil {
            valuesToSend["distance"] = geoDistance
            valuesToSend["latitude"] = latitude
            valuesToSend["longitude"] = longitude
        }
        
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(valuesToSend, options:NSJSONWritingOptions.PrettyPrinted)
            
            if task != nil {
                task.cancel()
            }
            
            task = session.uploadTaskWithRequest(request, fromData: data, completionHandler: {data, response, error in
                
                if error == nil {
                    let responseDictionary = self.convertStringToDictionary((NSString(data: data!, encoding: NSUTF8StringEncoding)! as String) as String)
                    
                    var respon = [[String: AnyObject]]()
                    
                    if let dictionaryResponse = responseDictionary["Resp"] as? [[String: AnyObject]] {
                        for row in dictionaryResponse {
                            respon.append(row)
                        }
                    }
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(respon)
                    }
                }
                else {
                    
                }
                
            })
            task.resume()
            
        } catch {
            
        }
    }
    
    //GET OR CREATE
    public func getOrCreate(completion: ([[String: AnyObject]]) -> ()) {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.HTTPAdditionalHeaders = ["Accept": "application/json",
                                        "Content-Type": "application/json"
        ]
        
        let session = NSURLSession(configuration: config)
        
        let request = NSMutableURLRequest(URL: NSURL(string: BASE_URL + "/parseql/index.php/parseQLController/getCreateObject")!)
        request.HTTPMethod = "POST"
        
        var valuesToSend: [String: AnyObject] = ["tableName": tableName, "fieldsDictionary": fields, "whereDictionary": whereKey, "limit": limit, "skip": skip]
        
        if orderByAsc != nil {
            valuesToSend["orderByAsc"] = orderByAsc
        }
        else if orderByDesc != nil {
            valuesToSend["orderByDesc"] = orderByDesc
        }
        
        if geoDistance != nil && latitude != nil && longitude != nil {
            valuesToSend["distance"] = geoDistance
            valuesToSend["latitude"] = latitude
            valuesToSend["longitude"] = longitude
        }
        
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(valuesToSend, options:NSJSONWritingOptions.PrettyPrinted)
            
            if task != nil {
                task.cancel()
            }
            
            task = session.uploadTaskWithRequest(request, fromData: data, completionHandler: {data, response, error in
                
                if error == nil {
                    let responseDictionary = self.convertStringToDictionary((NSString(data: data!, encoding: NSUTF8StringEncoding)! as String) as String)
                    
                    var respon = responseDictionary["Resp"] as! [[String: AnyObject]]
                    
                    if let dictionaryResponse = responseDictionary["Resp"] as? [[String: AnyObject]] {
                        for row in dictionaryResponse {
                            respon.append(row)
                        }
                    }
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(respon)
                    }
                }
                else {
                    
                }
                
            })
            task.resume()
            
        } catch {
            
        }
    }
    
    //UPDATE OR CREATE WITH BLOCK
    public func updateOrCreateWithBlock(completion: ([[String: AnyObject]]) -> ()) {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.HTTPAdditionalHeaders = ["Accept": "application/json",
                                        "Content-Type": "application/json"
        ]
        
        let session = NSURLSession(configuration: config)
        
        let request = NSMutableURLRequest(URL: NSURL(string: BASE_URL + "/parseql/index.php/parseQLController/updateCreateObject")!)
        request.HTTPMethod = "POST"
        
        let valuesToSend: [String: AnyObject] = ["tableName": tableName, "whereDictionary": whereKey, "fieldsToSet": setKey]
        
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(valuesToSend, options:NSJSONWritingOptions.PrettyPrinted)
            
            if task != nil {
                task.cancel()
            }
            
            task = session.uploadTaskWithRequest(request, fromData: data, completionHandler: {data, response, error in
                
                if error == nil {
                    let responseDictionary = self.convertStringToDictionary((NSString(data: data!, encoding: NSUTF8StringEncoding)! as String) as String)
                    
                    var respon = [[String: AnyObject]]()
                    
                    if let dictionaryResponse = responseDictionary["Resp"] as? [[String: AnyObject]] {
                        for row in dictionaryResponse {
                            respon.append(row)
                        }
                    }
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(respon)
                    }
                }
                else {
                    
                }
                
            })
            task.resume()
            
        } catch {
            
        }
    }
    
    //UPDATE WITH BLOCK
    public func updateWithBlock(completion: ([[String: AnyObject]]) -> ()) {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.HTTPAdditionalHeaders = ["Accept": "application/json",
                                        "Content-Type": "application/json"
        ]
        
        let session = NSURLSession(configuration: config)
        
        let request = NSMutableURLRequest(URL: NSURL(string: BASE_URL + "/parseql/index.php/parseQLController/updateObject")!)
        request.HTTPMethod = "POST"
        
        let valuesToSend: [String: AnyObject] = ["tableName": tableName, "whereDictionary": whereKey, "fieldsToSet": setKey]
        
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(valuesToSend, options:NSJSONWritingOptions.PrettyPrinted)
            
            if task != nil {
                task.cancel()
            }
            
            task = session.uploadTaskWithRequest(request, fromData: data, completionHandler: {data, response, error in
                
                if error == nil {
                    let responseDictionary = self.convertStringToDictionary((NSString(data: data!, encoding: NSUTF8StringEncoding)! as String) as String)
                    
                    var respon = [[String: AnyObject]]()
                    
                    if let dictionaryResponse = responseDictionary["Resp"] as? [[String: AnyObject]] {
                        for row in dictionaryResponse {
                            respon.append(row)
                        }
                    }
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(respon)
                    }
                }
                else {
                    
                }
                
            })
            task.resume()
            
        } catch {
            
        }
    }
    
    //UPDATE OR CREATE
    public func updateOrCreateWithBlock() {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.HTTPAdditionalHeaders = ["Accept": "application/json",
                                        "Content-Type": "application/json"
        ]
        
        let session = NSURLSession(configuration: config)
        
        let request = NSMutableURLRequest(URL: NSURL(string: BASE_URL + "/parseql/index.php/parseQLController/updateCreateObject")!)
        request.HTTPMethod = "POST"
        
        let valuesToSend: [String: AnyObject] = ["tableName": tableName, "whereDictionary": whereKey, "fieldsToSet": setKey]
        
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(valuesToSend, options:NSJSONWritingOptions.PrettyPrinted)
            
            if task != nil {
                task.cancel()
            }
            
            task = session.uploadTaskWithRequest(request, fromData: data, completionHandler: {data, response, error in
                
                if error == nil {
                    //TODO: Create block
                }
                else {
                    
                }
                
            })
            task.resume()
            
        } catch {
            
        }
    }
    
    //UPDATE
    public func update() {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.HTTPAdditionalHeaders = ["Accept": "application/json",
                                        "Content-Type": "application/json"
        ]
        
        let session = NSURLSession(configuration: config)
        
        let request = NSMutableURLRequest(URL: NSURL(string: BASE_URL + "/parseql/index.php/parseQLController/updateObject")!)
        request.HTTPMethod = "POST"
        
        let valuesToSend: [String: AnyObject] = ["tableName": tableName, "whereDictionary": whereKey, "fieldsToSet": setKey]
        
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(valuesToSend, options:NSJSONWritingOptions.PrettyPrinted)
            
            if task != nil {
                task.cancel()
            }
            
            task = session.uploadTaskWithRequest(request, fromData: data, completionHandler: {data, response, error in
                
                if error == nil {
                    //CORRECT
                }
                else {
                    
                }
                
            })
            task.resume()
            
        } catch {
            
        }
    }
    
    //DELETE
    public func delete() {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.HTTPAdditionalHeaders = ["Accept": "application/json",
                                        "Content-Type": "application/json"
        ]
        
        let session = NSURLSession(configuration: config)
        
        let request = NSMutableURLRequest(URL: NSURL(string: BASE_URL + "/parseql/index.php/parseQLController/deleteObject")!)
        request.HTTPMethod = "POST"
        
        var valuesToSend: [String: AnyObject] = ["tableName": tableName, "whereDictionary": whereKey, "limit": limit, "skip": skip]
        
        if orderByAsc != nil {
            valuesToSend["orderByAsc"] = orderByAsc
        }
        else if orderByDesc != nil {
            valuesToSend["orderByDesc"] = orderByDesc
        }
        
        if geoDistance != nil && latitude != nil && longitude != nil {
            valuesToSend["distance"] = geoDistance
            valuesToSend["latitude"] = latitude
            valuesToSend["longitude"] = longitude
        }
        
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(valuesToSend, options:NSJSONWritingOptions.PrettyPrinted)
            
            if task != nil {
                task.cancel()
            }
            
            task = session.uploadTaskWithRequest(request, fromData: data, completionHandler: {data, response, error in
                
                if error == nil {
                    //CORRECT
                }
                else {
                    
                }
                
            })
            task.resume()
            
        } catch {
            
        }
    }

    //DELETE WITH BLOCK
    public func deleteWithBlock(affectedRows completion: (Int) -> ()) {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.HTTPAdditionalHeaders = ["Accept": "application/json",
                                        "Content-Type": "application/json"
        ]
        
        let session = NSURLSession(configuration: config)
        
        let request = NSMutableURLRequest(URL: NSURL(string: BASE_URL + "/parseql/index.php/parseQLController/deleteObject")!)
        request.HTTPMethod = "POST"
        
        var valuesToSend: [String: AnyObject] = ["tableName": tableName, "whereDictionary": whereKey, "limit": limit, "skip": skip]
        
        if orderByAsc != nil {
            valuesToSend["orderByAsc"] = orderByAsc
        }
        else if orderByDesc != nil {
            valuesToSend["orderByDesc"] = orderByDesc
        }
        
        if geoDistance != nil && latitude != nil && longitude != nil {
            valuesToSend["distance"] = geoDistance
            valuesToSend["latitude"] = latitude
            valuesToSend["longitude"] = longitude
        }
        
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(valuesToSend, options:NSJSONWritingOptions.PrettyPrinted)
            
            if task != nil {
                task.cancel()
            }
            
            task = session.uploadTaskWithRequest(request, fromData: data, completionHandler: {data, response, error in
                
                if error == nil {
                    let responseDictionary = self.convertStringToDictionary((NSString(data: data!, encoding: NSUTF8StringEncoding)! as String) as String)
                    
                    let respon = responseDictionary["Resp"] as! [String: AnyObject]
                    
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(respon["affectedRows"] as! Int)
                    }
                }
                else {
                    
                }
                
            })
            task.resume()
            
        } catch {
            
        }
    }
    
    //COUNT
    public func count(completion: (Int) -> ()) {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.HTTPAdditionalHeaders = ["Accept": "application/json",
                                        "Content-Type": "application/json"
        ]
        
        let session = NSURLSession(configuration: config)
        
        let request = NSMutableURLRequest(URL: NSURL(string: BASE_URL + "/parseql/index.php/parseQLController/count")!)
        request.HTTPMethod = "POST"
        
        var valuesToSend: [String: AnyObject] = ["tableName": tableName, "whereDictionary": whereKey]
        
        if geoDistance != nil && latitude != nil && longitude != nil {
            valuesToSend["distance"] = geoDistance
            valuesToSend["latitude"] = latitude
            valuesToSend["longitude"] = longitude
        }
        
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(valuesToSend, options:NSJSONWritingOptions.PrettyPrinted)
            
            if task != nil {
                task.cancel()
            }
            
            task = session.uploadTaskWithRequest(request, fromData: data, completionHandler: {data, response, error in
                
                if error == nil {
                    let responseDictionary = self.convertStringToDictionary((NSString(data: data!, encoding: NSUTF8StringEncoding)! as String) as String)
                    
                    let respon = responseDictionary["Resp"] as! [String: AnyObject]
                    
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        completion(respon["affectedRows"] as! Int)
                    }
                }
                else {
                    
                }
                
            })
            task.resume()
            
        } catch {
            
        }
    }
    
    public func cancel() {
        if task != nil {
            task.cancel()
        }
    }
    
    public func whereKey(key: String, equalTo: AnyObject) {
        whereKey[key] = equalTo
    }
    
    public func whereKey(key: String, notEqualTo: AnyObject) {
        whereKey[key + " !="] = notEqualTo
    }
    
    public func whereKey(key: String, lessThan: AnyObject) {
        whereKey[key + " <"] = lessThan
    }
    
    public func whereKey(key: String, greaterThan: AnyObject) {
        whereKey[key + " >"] = greaterThan
    }
    
    public func whereKey(distanceLessOrEqual kilometers: Float, geoPoint point: PQLGeoPoint) {
        self.geoDistance = kilometers
        self.latitude = point.latitude
        self.longitude = point.longitude
    }
    
    public func setKey(key: String, value: AnyObject) {
        setKey[key] = value
    }

    //PRIVATE TOOLS
    
    internal func convertStringToDictionary(text: String) -> [String:AnyObject] {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return [String: AnyObject]()
    }
}

public class PQLGeoPoint {
    var latitude: Double!
    var longitude: Double!
    
    init (latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}