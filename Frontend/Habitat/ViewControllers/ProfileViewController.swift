//
//  ProfileViewController.swift
//  Habitat
//
//  Created by Chaz Clark on 9/24/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var backgroundTop: UIView!
    @IBOutlet weak var backgroundBottom: UIView!
    @IBOutlet weak var nameFirstLast: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var type: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        backgroundBottom.layer.cornerRadius = 24
        backgroundBottom.clipsToBounds = true
        backgroundTop.layer.cornerRadius = 24
        backgroundTop.clipsToBounds = true
        profileImage.layer.cornerRadius = 24
        profileImage.clipsToBounds = true
        getUserInfo()
    }
    
    func getUserInfo() {
        var userId = UserDefaults.standard.integer(forKey: "userId")
        //TODO: If there is a userID just get rest info from saved data else fetch new data
        HabitatAPI.UserAPI().getUserInfo(userNum: userId)

    }
    
    func getSavedUserInfo() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
