//
//  RegisterViewController.swift
//  Markt
//
//  Created by Jordan Furr on 6/23/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpViews()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func registerTapped(_ sender: Any) {
        guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let email = emailTextField.text,
            let password = passwordTextField.text, let confirm = confirmTextField.text else {return}
        
        //MARK: MAKE SURE USER CAN REGISTER
        if email.components(separatedBy: "@").last != "umich.edu" {
            presentNonUmichEMailALert()
            return
        }
        
        if email == "" || firstName == "" || lastName == "" {
            presentFillInTextFieldsAlert()
            return
        }
        if password != confirm {
            presentMisMatchPasswordAlert()
            return
        }
        if password.count < 6 {
            presentShortPasswordAlert()
            return
        }
        
        UserController.shared.signup(firstName: firstName, lastName: lastName, email: email, password: password) { (success, error) in
            if let error = error {
                print(error.localizedDescription)
                self.presentRegisterAlertView(error: error)
            } else {
                UserController.shared.initUser(uid: Auth.auth().currentUser!.uid)
                UserController.shared.updatedUser()
                self.performSegue(withIdentifier: "newUser", sender: self)
            }
        }
    }
    
    
    //MARK: HELPER IB ACTIONS
    
    @IBAction func backgroundTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: HELPER ALERTS
    
    func setUpViews(){
        emailTextField.autocorrectionType = .yes
        passwordTextField.autocorrectionType = .no
        confirmTextField.autocorrectionType = .no
    }
    func presentMisMatchPasswordAlert(){
        let alertController = UIAlertController(title: "Passwords do not match", message: "Please re-type password", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentShortPasswordAlert(){
        let alertController = UIAlertController(title: "Password is too short", message: "Password must be at least 6 characters", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentFillInTextFieldsAlert() {
        let alertController = UIAlertController(title: "Missing Info", message: "Please fill in all fields", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentNonUmichEMailALert() {
        let alertController = UIAlertController(title: "Unable to register user", message: "A umich.edu email address is required to register for Markt", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentRegisterAlertView(error: Error) {
        let alertController = UIAlertController(title: "Error Creating Account", message: error.localizedDescription, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}



