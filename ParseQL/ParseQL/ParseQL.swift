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
    
    let PRIVATE_KEY: String = "dnuehjbdq834+ç´`"
    let TOKEN: String = "`p+23049diqowedqhd++ç!ª!·"
    
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
            
            //DICTIONARY TO SEND
            let valuesToSend: [String: AnyObject] = ["token": TOKEN, "tableName": tableName, "fieldsDictionary": fields]
            
            //ENCRYPT DICTIONARY
            let valuesToSendEncrypted = ["encryptedData": encryptDictionaryJson(valuesToSend)]
            
            
            do {
                let data = try NSJSONSerialization.dataWithJSONObject(valuesToSendEncrypted, options:NSJSONWritingOptions.PrettyPrinted)
                
                if task != nil {
                    task.cancel()
                }
                
                task = session.uploadTaskWithRequest(request, fromData: data, completionHandler: {data, response, error in
                    
                    if error == nil {
                        //CORRECT
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
            
            //DICTIONARY TO SEND
            let valuesToSend: [String: AnyObject] = ["token": TOKEN, "tableName": tableName, "fieldsDictionary": fields]
            
            //ENCRYPT DICTIONARY
            let valuesToSendEncrypted = ["encryptedData": encryptDictionaryJson(valuesToSend)]
            
            do {
                let data = try NSJSONSerialization.dataWithJSONObject(valuesToSendEncrypted, options:NSJSONWritingOptions.PrettyPrinted)
                
                if task != nil {
                    task.cancel()
                }
                
                task = session.uploadTaskWithRequest(request, fromData: data, completionHandler: {data, response, error in
                    
                    if error == nil {
                        let responseDictionary = self.convertStringToDictionary((NSString(data: data!, encoding: NSUTF8StringEncoding)! as String) as String)
                        let resp = responseDictionary["encryptedData"] as! String
                        
                        //DESENCRYPTED JSON IN STRING FORMAT
                        let desencryptedString = self.desencryptByteArray(resp)
                        
                        //DESENCRYPTED JSON
                        let desencryptedJson = self.convertStringToDictionary(desencryptedString)
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            completion(desencryptedJson["Resp"] as! String)
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
    public func updateOrCreate() {
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
    
    internal func xorWithKey(byteArray: [UInt8], key: String) -> [UInt8] {
        var i = 0
        
        var resultByteArray: [UInt8] = byteArray
        let keyCharArray: [UInt8] = [UInt8](key.utf8)
        
        for j in 0..<byteArray.count {
            
            resultByteArray[j] ^= keyCharArray[i]
            
            //CNT
            i += 1
            if i >= keyCharArray.count {
                i = 0
            }
        }
        
        return resultByteArray
    }
    
    internal func encryptDictionaryJson (dictionary: [String: AnyObject]) -> [Int] {
        var encryptedData = [UInt8]()
        do {
            let dataToEncrypt = try NSJSONSerialization.dataWithJSONObject(dictionary, options:NSJSONWritingOptions.PrettyPrinted)
            
            let count = dataToEncrypt.length / sizeof(UInt8)
            var dataToEncryptArray = [UInt8](count: count, repeatedValue: 0)
            dataToEncrypt.getBytes(&dataToEncryptArray, length:count * sizeof(UInt8))
            
            encryptedData = xorWithKey([UInt8](String(data: dataToEncrypt, encoding: NSUTF8StringEncoding)!.utf8), key: PRIVATE_KEY)
        }
        catch {
            
        }
        
        var encryptedArray = [Int]()
        
        for uint8 in encryptedData {
            encryptedArray.append(Int(uint8))
        }
        
        return encryptedArray
    }
    
    internal func desencryptByteArray(byteArrayStringBefore: String) -> String {
        var byteArrayInt = [Int]()
        var byteArrayStringToParse = byteArrayStringBefore
        
        byteArrayStringToParse = byteArrayStringToParse.stringByReplacingOccurrencesOfString("[", withString: "")
        byteArrayStringToParse = byteArrayStringToParse.stringByReplacingOccurrencesOfString("]", withString: "")
        
        let byteArrayString = byteArrayStringToParse.componentsSeparatedByString(",")
        
        for int in byteArrayString {
            byteArrayInt.append(Int(int)!)
        }
        
        
        var resultArray: [UInt8] = [UInt8]()
        
        for char in byteArrayInt {
            resultArray.append(UInt8(char))
        }
        
        let desencryptedArray = self.xorWithKey(resultArray, key: self.PRIVATE_KEY)
        
        let stringResp = String(bytes: desencryptedArray, encoding: NSUTF8StringEncoding)
        
        return stringResp!
    }
    
    //TESTS
    //SAVE WITH BLOCK TEST
    public func saveWithBlockTest(completion: (String) -> ()) {
        if (fields.count > 0) {
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            config.HTTPAdditionalHeaders = ["Accept": "application/json",
                                            "Content-Type": "application/json"
            ]
            
            let session = NSURLSession(configuration: config)
            
            let request = NSMutableURLRequest(URL: NSURL(string: BASE_URL + "/parseql/index.php/parseQLController/saveObjectTest")!)
            request.HTTPMethod = "POST"
            
            //DICTIONARY TO SEND
            let valuesToSend: [String: AnyObject] = ["tableName": tableName, "fieldsDictionary": fields]
            
            //ENCRYPT DICTIONARY
            let valuesToSendEncrypted = ["encryptedData": encryptDictionaryJson(valuesToSend)]
            
            do {
                let data = try NSJSONSerialization.dataWithJSONObject(valuesToSendEncrypted, options:NSJSONWritingOptions.PrettyPrinted)
                
                if task != nil {
                    task.cancel()
                }
                
                task = session.uploadTaskWithRequest(request, fromData: data, completionHandler: {data, response, error in
                    
                    if error == nil {
                        let responseDictionary = self.convertStringToDictionary((NSString(data: data!, encoding: NSUTF8StringEncoding)! as String) as String)
                        let resp = responseDictionary["encryptedData"] as! String
                        
                        //DESENCRYPTED JSON IN STRING FORMAT
                        let desencryptedString = self.desencryptByteArray(resp)
                        
                        //DESENCRYPTED JSON
                        //let desencryptedJson = self.convertStringToDictionary(desencryptedString)
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            completion(desencryptedString)
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
}

public class PQLGeoPoint {
    var latitude: Double!
    var longitude: Double!
    
    init (latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}