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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        
        if email != "" || password != "" {
            UserController.shared.login(email: email, password: password) { (_, error)  in
                if let error = error {
                    print(error)
                    self.presentLoginAlertView(error: error)
                } else {
                    UserController.shared.fetchCurrentUser { (result) in
                        switch result {
                        case .failure(let error):
                            print("error fetching user", error)
                        case .success(let user):
                            print("user fetched successfully")
                            UserController.shared.currentUser = user
                            self.performSegue(withIdentifier: "loggedIn", sender: self)
                        }
                    }
                    print("logging user in")
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
    
    func presentLoginAlertView(error: Error) {
        let alertController = UIAlertController(title: "Error Loggin In", message: error.localizedDescription, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}
