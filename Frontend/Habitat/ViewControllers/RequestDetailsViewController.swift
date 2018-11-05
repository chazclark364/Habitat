//
//  RequestDetailsViewController.swift
//  Habitat
//
//  Created by Travis Stanger on 10/15/18.
//  Copyright © 2018 PP1. All rights reserved.
//
//  This view controller will show a single request, the details for that request,
//    the progress bar (submitted/approved/in progress/complete), cancel request
//    (for tenant), update status (for landlord/worker), add a comment? (for any
//    user type), back button to return to main maintenance page with history
//

import Foundation
import UIKit


class RequestDetailsViewController: UIViewController {
    //TODO: Construct a user object
    @IBOutlet weak var stageSubmitted: UIView!
    @IBOutlet weak var stageInProgress: UIView!
    @IBOutlet weak var stageApproved: UIView!
    @IBOutlet weak var stageCompleted: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stageSubmitted.layer.cornerRadius = 5
        stageSubmitted.clipsToBounds = true
        stageInProgress.layer.cornerRadius = 5
        stageInProgress.clipsToBounds = true
        stageApproved.layer.cornerRadius = 5
        stageApproved.clipsToBounds = true
        stageCompleted.layer.cornerRadius = 5
        stageCompleted.clipsToBounds = true
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
