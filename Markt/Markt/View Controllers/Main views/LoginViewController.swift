//
//  LoginViewController.swift
//  Markt
//
//  Created by Jordan Furr on 6/23/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: IB OUTLETS
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    //MARK: - Life Cycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: IB Actions
    
    @IBAction func loginTapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        
        //Handles empty Fields
        if email == "" || password == "" {
          self.presentMissingInfoAlertView()
        }
        
        UserController.shared.login(email: email, password: password) { (_, error)  in
            if let error = error {
                self.presentLoginAlertView(error: error); print(error)
            } else {
                //Fetch current user
                UserController.shared.fetchCurrentUser { (result) in
                    switch result {
                    case .failure(let error):
                        self.presentLoginAlertView(error: error); print("error fetching user", error)
                    case .success(let user):
                        UserController.shared.currentUser = user; print("user fetched successfully")
                        self.performSegue(withIdentifier: "loggedIn", sender: self)
                    }
                }
            }
        }
    }
    @IBAction func backgroundtapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func cancelTapped(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
}
