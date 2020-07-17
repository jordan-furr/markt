//
//  SettingsViewController.swift
//  Markt
//
//  Created by Jordan Furr on 7/6/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    //MARK: - Life Cycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
