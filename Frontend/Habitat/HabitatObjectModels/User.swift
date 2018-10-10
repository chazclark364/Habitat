//
//  User.swift
//  Habitat
//
//  Created by Chaz Clark on 9/29/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation


//This is a Habitat User Object. Set properties of the User in this class
class User: NSObject  {
    var userId: Int?
    var dateCreated: Date?
    var firstName: String?
    var lastName: String?
    var email: String?
    var phoneNumber: String?
    var password: String?
    var type: String?
    
    //TODO: This should have an Init function
    func User(_ iD: Int, _ date: Date,_ fName: String, _ lName: String, _ pNumber: String) {
        userId = iD
        dateCreated = date
        firstName = fName
        lastName = lName
        phoneNumber = pNumber
    }
    
}
