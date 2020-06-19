//
//  ContainerViewController.swift
//  Markt
//
//  Created by Jordan Furr on 6/19/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    var sideMenuOpen = false
    
    @objc func toggleSideMenu(){
        if sideMenuOpen {
            sideMenuOpen = false
            sideMenuConstraint.constant = -320
        } else {
            sideMenuOpen = true
            sideMenuConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func menuContainerTapped(_ sender: Any) {
        toggleSideMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(toggleSideMenu), name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
}