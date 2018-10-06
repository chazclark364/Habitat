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
    
    let status = Alamofire.request("https://httpbin.org/get", parameters: ["foo": "bar"])
    .validate(statusCode: 200..<300)
    .validate(contentType: ["application/json"])
    .response { response in
    // response handling code
    }
    
}

class UserAPI {
    
    func createUser(user: User) -> Int {
        
        //set the JSON parameters here
        let parameters: [String: AnyObject] = [
            "firstName" : user.firstName as AnyObject,
            "lastName" : user.lastName as AnyObject,
            "email" : user.email as AnyObject,
            "password" : user.password as AnyObject,
            "userType" : user.type as AnyObject,
            "phoneNumber" : user.phoneNumber as AnyObject
        ]
        //Is this request done asynchronously
        Alamofire.request("insert my api route", method: .post, parameters: parameters, encoding: JSONEncoding.default)

        
        
    }
//    func createUser(user: User,
//                progressCompletion: @escaping (_ percent: Float) -> Void,
//                completion: @escaping (_ userReturned: User?) -> Void) {
//        // 1
//        guard let imageData = UIImageJPEGRepresentation(image, 0.5) else {
//            print("Could not get JPEG representation of UIImage")
//            return
//        }
//        
//        // 2
//        Alamofire.upload(multipartFormData: { multipartFormData in
//            multipartFormData.append(imageData,
//                                     withName: "imagefile",
//                                     fileName: "image.jpg",
//                                     mimeType: "image/jpeg")
//        },
//                         //Insert API Rout below
//                         to: "http://api.imagga.com/v1/content",
//                         //Decide what authorization for user not created yet
//                        //probably should turn off authorization off
//                         headers: ["Authorization": "Basic xxx"],
//                         encodingCompletion: { encodingResult in
//                            //Should call log in api
//        })
//    }
//    
}


//
//Alamofire.request(.POST, "http://myserver.com", parameters: parameters, encoding: .JSON)
//    .responseJSON { request, response, JSON, error in
//        print(response)
//        print(JSON)
//        print(error)
//}



//
//let parameters = [
//    "username": "foo",
//    "password": "123456"
//]
//
//Alamofire.request(.POST, "https://httpbin.org/post", parameters: parameters, encoding: .JSON)
//// -> HTTP body: {"foo": [1, 2, 3], "bar": {"baz": "qux"}}
