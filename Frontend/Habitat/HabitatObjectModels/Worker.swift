//
//  Worker.swift
//  Habitat
//
//  Created by Travis Stanger on 11/5/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation

//This is a Habitat Worker Object. Set properties of the Worker in this class
class Worker: NSObject  {
    var workerId: Int?
    var company: String?
    
    func Worker(_ idWorker: Int, _ co: String) {
        workerId = idWorker
        company = co
    }
}

