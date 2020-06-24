//
//  LaunchViewController.swift
//  Markt
//
//  Created by Jordan Furr on 6/23/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit
import FirebaseAuth

class LaunchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
      // UserController.shared.signoutCurrentUser()
        DispatchQueue.main.async {
            if Auth.auth().currentUser != nil {
                UserController.shared.fetchCurrentUser { (result) in
                    switch result {
                    case .failure(let error):
                        print("error fetching user", error)
                        self.performSegue(withIdentifier: "noUser", sender: self)
                    case .success(let user):
                        print("user fetched successfully")
                        UserController.shared.currentUser = user
                        self.performSegue(withIdentifier: "userFound", sender: self)
                    }
                    
                }
            } else {
                print("no user logged in")
                self.performSegue(withIdentifier: "noUser", sender: self)
            }
        }
    }
}