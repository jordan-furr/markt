//
//  SideMenuTableViewController.swift
//  Markt
//
//  Created by Jordan Furr on 6/19/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class SideMenuTableViewController: UITableViewController {
    
   
    //MARK: - Life Cycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: - Table View Delegate/Data Source Functions
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "ShowProfile", sender: self)
        case 1:
             performSegue(withIdentifier: "ShowSettings", sender: self)
        case 2:
             performSegue(withIdentifier: "ShowAbout", sender: self)
        default: break
        }
        //NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    
    //MARK: - Table View Style
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120.0
    }
}
