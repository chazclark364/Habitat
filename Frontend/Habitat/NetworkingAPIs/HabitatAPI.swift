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
        func createUser(user: User, completion: @escaping (User?) -> Void) -> User? {
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
            //Is this request done asynchronously
            //Unsupported URL
            Alamofire.request("http://proj309-pp-01.misc.iastate.edu:8080/users/new", method: .post, parameters: parameters, encoding: JSONEncoding.default)

                // 2
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
                        returnedUser = self.userFromJSON(json: json as! NSDictionary)
                        completion(returnedUser)
                    }
            }
            //Returning 0 will always default to error
            return returnedUser
        }
        
        func loginUser(email: String, password: String) -> User? {
         return User()
        }
        
        func userFromJSON(json: NSDictionary) -> User? {
            let user = User()
            user.firstName = json.object(forKey: "firstName") as? String
            user.lastName = json.object(forKey: "lastName") as? String
            user.phoneNumber = json.object(forKey: "phoneNumber") as? String
            user.type = json.object(forKey: "userType") as? String
            user.email = json.object(forKey: "email") as? String
            return user
        }
    }
}
