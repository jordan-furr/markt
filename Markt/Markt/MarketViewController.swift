//
//  MarketViewController.swift
//  Markt
//
//  Created by Jordan Furr on 6/18/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class MarketViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true

        // Do any additional setup after loading the view.
    }
    

    @IBAction func menuTapped(_ sender: Any) {
        print("toggle side menu")
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }

}
