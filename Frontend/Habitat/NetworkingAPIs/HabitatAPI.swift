//
//  HabitatAPI.swift
//  Habitat
//
//  Created by Chaz Clark on 9/29/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation
import Alamofire

/**
 The purpose of this file is to handle all networking task.
 
 Coding Style:
 
 *This file will be organzied by object. Every object will have an API
 call associated witht that specific object.
 
 *Every API call needs to be called on a seperate thread:
 
 */

class HabitiatAPI {
    var newCall = Alamofire.request("https://httpbin.org/get")
    var data = Alamofire.request("https://httpbin.org/get").responseJSON { response in
    print("Request: \(String(describing: response.request))")   // original url request
    print("Response: \(String(describing: response.response))") // http url response
    print("Result: \(response.result)")                         // response serialization result
    
    if let json = response.result.value {
    print("JSON: \(json)") // serialized json response
    }
    
    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
    print("Data: \(utf8Text)") // original server data as UTF8 string
    }
    }
    
}
