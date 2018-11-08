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
        
        func landlordSearch(completion: @escaping ([Landlord]?) -> Void) {
            let landlordURL = "http://proj309-pp-01.misc.iastate.edu:8080/landlords/all"
            Alamofire.request(landlordURL).responseJSON { response in
                
                switch response.result {
                case .success:
                    print("Validation Successful")
                case .failure(let error):
                    print(error)
                }
                
                if let json = response.result.value {
                    print("JSON: \(json)") // serialized json response
                }
            }
        }

        func loginUser(email: String, password: String, viewController: UIViewController, completion: @escaping (User?) -> Void) {
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
                        viewController.present(AlertViews().errorAlert(msg: error.localizedDescription), animated: true)
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
        
        func updateUserInfo(user: User, completion: @escaping (User?) -> Void) {
            var returnedUser: User?
            let parameters: [String: AnyObject] = [
            "firstName" : user.firstName as AnyObject,
            "lastName" : user.lastName as AnyObject,
            "email" : user.email as AnyObject,
            "idUsers" : user.userId as AnyObject,
            "userType" : user.type as AnyObject,
            "phoneNumber" : user.phoneNumber as AnyObject,
            "password" : user.password as AnyObject ]
            
            let updateURL = "http://proj309-pp-01.misc.iastate.edu:8080/users/update/"
            Alamofire.request(updateURL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                
                .responseJSON { response in
                switch response.result {
                case .success:
                    print("Update Successful")
                case .failure(let error):
                    print(error)
                }
                
                if let json = response.result.value {
                    print("JSON: \(json)")
                    returnedUser = User().userFromJSON(json: json as! NSDictionary)
                    completion(returnedUser)
                }
            }
        }
        
        func updateLandlord(landlord: Landlord, completion: @escaping (Landlord?) -> Void) {
            var returnedLandlord: Landlord?
            let parameters: [String: AnyObject] = [
                "id_landlord" : landlord.landlordId as AnyObject,
                "address" : landlord.address as AnyObject ]
            
            let updateURL = "http://proj309-pp-01.misc.iastate.edu:8080/landlord/update"
            Alamofire.request(updateURL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                
                .responseJSON { response in
                switch response.result {
                case .success:
                    print("Update Landlord Successful")
                case .failure(let error):
                    print(error)
                }
                
                if let json = response.result.value {
                    print("JSON: \(json)")
                    returnedLandlord = Landlord().landlordFromJSON(json: json as! NSDictionary)
                    completion(returnedLandlord)
                }
            }
        }
        
        func updateWorker(worker: Worker, completion: @escaping (Worker?) -> Void) {
            var returnedWorker: Worker?
            let parameters: [String: AnyObject] = [
                "id_worker" : worker.workerId as AnyObject,
                "company" : worker.company as AnyObject ]
            
            let updateURL = "http://proj309-pp-01.misc.iastate.edu:8080/worker/update/"
            Alamofire.request(updateURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                switch response.result {
                case .success:
                    print("Update Worker Successful")
                case .failure(let error):
                    print(error)
                }
                
                if let json = response.result.value {
                    print("JSON: \(json)")
                    returnedWorker = Worker().workerFromJSON(json: json as! NSDictionary)
                    completion(returnedWorker)
                }
            }
        }
        
        func updateTenant(tenant: Tenant, completion: @escaping (Tenant?) -> Void) {
            var returnedTenant: Tenant?
            let parameters: [String: AnyObject] = [
                "idTenant" : tenant.tenantId as AnyObject,
                "landlord" : tenant.landlordId as AnyObject,
                "residence" : tenant.residence as AnyObject,
                "monthlyRent" : tenant.monthlyRent as AnyObject ]
            
            let updateURL = "http://proj309-pp-01.misc.iastate.edu:8080/tenant/update"
            Alamofire.request(updateURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                switch response.result {
                case .success:
                    print("Update Tenant Successful")
                case .failure(let error):
                    print(error)
                }
                
                if let json = response.result.value {
                    print("JSON: \(json)")
                    //returnedWorker = self.workerFromJSON(json: json as! NSDictionary)
                    returnedTenant = Tenant().tenantFromJSON(json: json as! NSDictionary)
                    completion(returnedTenant)
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
        
        func getTenant(userId: Int, completion: @escaping (Tenant?) -> Void) {
            var returnedTenant: Tenant?
            var userURL = "http://proj309-pp-01.misc.iastate.edu:8080/tenant/\(userId)"
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
                        returnedTenant = Tenant().tenantFromJSON(json: json as! NSDictionary)
                        completion(returnedTenant)
                    }
            }
            
        }
        
        func getLandlords(completion: @escaping ([Landlord]?) -> Void) {
            var landLords =  [Landlord()]
            var count = 0
            var userURL = "http://proj309-pp-01.misc.iastate.edu:8080/landlords/all"
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
                            let boss = Landlord().landlordFromJSON(json: object as! NSDictionary) ?? Landlord()
                            landLords.insert(boss, at: count)
                            count += 1
                        }
                        completion(landLords)
                    }
            }
        }
        
    }
    
    class RequestAPI {
        
        func createRequest(request: MaintenanceRequest?, completion: @escaping (MaintenanceRequest?) -> Void) {
              var returnedRequest: MaintenanceRequest?
            
            let parameters: [String: AnyObject] = [
                "title" : request?.title as AnyObject,
                "idRequest" : request?.requestId as AnyObject,
                "requestee" : request?.requestee as AnyObject,
                "landlord" : request?.landlord as AnyObject,
                "description" : request?.requestDescription as AnyObject,
                "status" : request?.status as AnyObject
            ]
            
            Alamofire.request("http://proj309-pp-01.misc.iastate.edu:8080/request/new", method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
                        returnedRequest = MaintenanceRequest().requestFromJSON(json: json as! NSDictionary)
                        completion(returnedRequest)
                    }
            }
            
        }
        
        func getRequestForId(userId: Int, completion: @escaping ([MaintenanceRequest]?) -> Void) {
            var count = 0
            var requestService = [MaintenanceRequest()]
            var userURL = "http://proj309-pp-01.misc.iastate.edu:8080/users/\(userId)/requests"
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
                            let service = MaintenanceRequest().requestFromJSON(json: object as! NSDictionary) ?? MaintenanceRequest()
                            requestService.insert(service, at: count)
                            count += 1
                        }
                        completion(requestService)
                    }
            }
        }
        
        func updateRequest(userId: Int, request: MaintenanceRequest?, completion: @escaping (MaintenanceRequest?) -> Void) {
            var returnedRequest: MaintenanceRequest?
            
            let parameters: [String: AnyObject] = [
                "title" : request?.title as AnyObject,
                "idRequest" : request?.requestId as AnyObject,
                "requestee" : request?.requestee as AnyObject,
                "landlord" : request?.landlord as AnyObject,
                "description" : request?.requestDescription as AnyObject,
                "status" : request?.status as AnyObject
            ]
            
            Alamofire.request("http://proj309-pp-01.misc.iastate.edu:8080/request/request/update/\(userId)", method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
                        returnedRequest = MaintenanceRequest().requestFromJSON(json: json as! NSDictionary)
                        completion(returnedRequest)
                    }
            }
            
        }
    }
}
