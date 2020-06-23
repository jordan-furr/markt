//
//  SideMenuTableViewController.swift
//  Markt
//
//  Created by Jordan Furr on 6/19/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class SideMenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
}
