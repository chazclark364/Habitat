//
//  LandlordSelectViewController.swift
//  Habitat
//
//  Created by Travis Stanger on 11/4/18.
//  Copyright © 2018 PP1. All rights reserved.
//

import Foundation
import UIKit

class LandlordSelectViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        HabitatAPI.UserAPI().landlordSearch(completion: {  landlordArray in
        })
        for i in 0...1000 {
            data.append("\(i)")
            
        }
        
        tableView.dataSource = self
    }
    
    private var data: [String] = []
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! //1.
        
        let text = data[indexPath.row] //2.
        
        cell.textLabel?.text = text //3.
        
        return cell //4.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
