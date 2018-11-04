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

class HabitatAPI {
    
    //User API's
    class UserAPI {
        //TODO: Return user once passed test
        func createUser(user: User, completion: @escaping (User?) -> Void) {
            var returnedUser: User?
            //set the JSON parameters here
            let parameters: [String: AnyObject] = [
                "firstName" : user.firstName as AnyObject,
                "lastName" : user.lastName as AnyObject,
                "email" : user.email as AnyObject,
                "password" : user.password as AnyObject,
                "userType" : user.type as AnyObject,
                "phoneNumber" : user.phoneNumber as AnyObject
            ]
            
            Alamofire.request("http://proj309-pp-01.misc.iastate.edu:8080/users/new", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                
                .responseJSON { response in
                    //See if status is good
                    switch response.result {
                    case .success:
                        print("Validation Successful")
                    case .failure(let error):
                        print(error)
                    }
                    
                    if let json = response.result.value {
                        print("JSON: \(json)") // serialized json response
                         //TODO: Test new USER to JSON Function
                        returnedUser = User().userFromJSON(json: json as! NSDictionary)
                        completion(returnedUser)
                    }
            }
        }
        
        func loginUser(email: String, password: String, completion: @escaping (User?) -> Void) {
            var returnedUser: User?
            let parameters: [String: AnyObject] = [
                "email" : email as AnyObject,
                "password" : password as AnyObject
            ]
            Alamofire.request("http://proj309-pp-01.misc.iastate.edu:8080/login", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                
                .responseJSON { response in
                    //See if status is good
                    switch response.result {
                    case .success:
                        print("Validation Successful")
                    case .failure(let error):
                        print(error)
                        completion(returnedUser)
                    }
                    
                    if let json = response.result.value {
                        print("JSON: \(json)") // serialized json response
                         //TODO: Test new USER to JSON Function
                        returnedUser = User().userFromJSON(json: json as! NSDictionary)
                        completion(returnedUser)
                    }
            }
        }
        
        func getUserInfo(userId: Int, completion: @escaping (User?) -> Void) {
            var returnedUser: User?
            var userURL = "http://proj309-pp-01.misc.iastate.edu:8080/users/"
            userURL += String(userId)
            Alamofire.request(userURL)
                .responseJSON { response in
                    //See if status is good
                    switch response.result {
                    case .success:
                        print("Validation Successful")
                    case .failure(let error):
                        print(error)
                    }
                    
                    if let json = response.result.value {
                        print("JSON: \(json)") // serialized json response
                        //TODO: Test new USER to JSON Function
                        returnedUser = User().userFromJSON(json: json as! NSDictionary)
                        completion(returnedUser)
                    }
            }
            
        }
        
    }
    
    class RequestAPI {
        func getRequestForId(userId: Int, completion: @escaping ([MaintenanceRequest]?) -> Void) {
            var request: [MaintenanceRequest]?
            var userURL = "http://proj309-pp-01.misc.iastate.edu:8080/users/\(userId)/requests"
            userURL += String(userId)
            Alamofire.request(userURL)
                .responseJSON { response in
                    //See if status is good
                    switch response.result {
                    case .success:
                        print("Validation Successful")
                    case .failure(let error):
                        print(error)
                    }
                    
                    if let json = response.result.value as? [Any] {
                        print("JSON: \(json)") // serialized json response
                        //TODO: See if this grabs all the request and parse properly
                        for object in json {
                            request?.append(MaintenanceRequest().requestFromJSON(json: object as! NSDictionary) ?? MaintenanceRequest())
                        }
                        completion(request)
                    }
            }
            
        }
    }
}
