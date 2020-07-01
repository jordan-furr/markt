//
//  MarketViewController.swift
//  Markt
//
//  Created by Jordan Furr on 6/18/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class MarketViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func menuTapped(_ sender: Any) {
        print("toggle side menu")
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    
    
    //MARK: HELPERS
    
    func setUpViews() {
        navigationItem.hidesBackButton = true
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showProfile),
                                               name: NSNotification.Name("ShowProfile"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showSettings),
                                               name: NSNotification.Name("ShowSettings"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showAbout),
                                               name: NSNotification.Name("ShowAbout"),
                                               object: nil)
        ListingController.shared.fetchCurrentUsersListings { (result) in
            switch result {
            case .failure(let error):
                print("Could not fetch user's live listings")
                print(error, error.localizedDescription)
            case .success(let listings):
                print("live user listings fetched"); if (listings != nil) { print(listings!)}
            }
        }
        
    
    }
    @objc func showProfile() {
        performSegue(withIdentifier: "ShowProfile", sender: nil)
    }
    @objc func showSettings() {
        performSegue(withIdentifier: "ShowSettings", sender: nil)
    }
    @objc func showAbout() {
        performSegue(withIdentifier: "ShowAbout", sender: nil)
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        self.view.endEditing(true)
        if sideMenuOpen {
            menuTapped(true)
            sideMenuOpen = false
        }
        
    }
    
    @IBAction func swipedLeftToMenu(_ sender: Any) {
        menuTapped(self)
    }
    
    
}
