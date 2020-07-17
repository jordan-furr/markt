//
//  ContainerViewController.swift
//  Markt
//
//  Created by Jordan Furr on 6/19/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

var sideMenuOpen = false

class ContainerViewController: UIViewController {
    
    //MARK: - IB OUTLETS
    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    @IBOutlet weak var marketContainer: UIView!
    @IBOutlet weak var sideMenucontainer: UIView!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    //MARK: - Life Cycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUp()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Helpers
    @objc func toggleSideMenu(){
        if sideMenuOpen {
            sideMenuOpen = false;
            sideMenuConstraint.constant = -342
            marketContainer.isUserInteractionEnabled = true
        } else {
            sideMenuConstraint.constant = 0;
            marketContainer.isUserInteractionEnabled = false
            sideMenuOpen = true;
        }
        UIView.animate(withDuration: 0.3){ self.view.layoutIfNeeded()
        }
    }
    
    func setUp(){
        tapGesture.cancelsTouchesInView = false
        sideMenucontainer.isUserInteractionEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(toggleSideMenu), name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    //MARK: Navigation
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        if sideMenuOpen {
            print("tapped")
            let touchPoint = sender.location(in: view)
            if marketContainer.frame.contains(touchPoint) {
                self.toggleSideMenu()
            }
        }
    }
    
    @IBAction func swipeBack(_ sender: Any) {
        if (sideMenuOpen){
            self.toggleSideMenu()
        }
    }
}
