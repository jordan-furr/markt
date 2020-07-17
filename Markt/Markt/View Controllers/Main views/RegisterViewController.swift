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
    
    //MARk: IB Outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    
    //MARK: Life Cycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: IB ACTIONS
    
    @IBAction func registerTapped(_ sender: Any) {
        guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let email = emailTextField.text,
            let password = passwordTextField.text, let confirm = confirmTextField.text else {return}
        
        //MARK: MAKE SURE USER CAN REGISTER
        if email.components(separatedBy: "@").last != "umich.edu" { presentNonUmichEMailALert(); return }
        if email == "" || firstName == "" || lastName == "" { presentFillInTextFieldsAlert(); return }
        if password != confirm { presentMisMatchPasswordAlert(); return }
        if password.count < 6 { presentShortPasswordAlert(); return }
        
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
    
    @IBAction func backgroundTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Helpers
    func setUpViews(){
        emailTextField.autocorrectionType = .yes
        passwordTextField.autocorrectionType = .no
        confirmTextField.autocorrectionType = .no
        passwordTextField.textContentType = .none
        passwordTextField.isSecureTextEntry = false
    }
}


