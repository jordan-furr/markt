//
//  AlertService.swift
//  Markt
//
//  Created by Jordan Furr on 7/12/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

//MARK: ALERTS FOR OTHER VIEW CONTROLLERS
extension LoginViewController {
    func presentLoginAlertView(error: Error) {
         let alertController = UIAlertController(title: "Error Loggin In", message: error.localizedDescription, preferredStyle: .alert)
         let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
         alertController.addAction(defaultAction)
         present(alertController, animated: true, completion: nil)
     }
     func presentMissingInfoAlertView() {
         let alertController = UIAlertController(title: "Error Loggin In", message: "Please fill in both email and password fields", preferredStyle: .alert)
         let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
         alertController.addAction(defaultAction)
         present(alertController, animated: true, completion: nil)
     }
}

extension RegisterViewController {
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

class AlertService {
    
    static func showAlert(style: UIAlertController.Style, title: String?, message: String?, actions: [UIAlertAction] = [UIAlertAction(title: "Ok", style: .cancel, handler: nil)], completion: (() -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            alert.addAction(action)
        }
        if let topVC = UIApplication.getTopMostViewController() {
            alert.popoverPresentationController?.sourceView = topVC.view
            alert.popoverPresentationController?.sourceRect = CGRect(x: topVC.view.bounds.midX, y: topVC.view.bounds.midY, width: 0, height: 0)
            alert.popoverPresentationController?.permittedArrowDirections = []
            topVC.present(alert, animated: true, completion: completion)
        }
    }
}

extension UIApplication {
    class func getTopMostViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopMostViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopMostViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopMostViewController(base: presented)
        }
        return base
    }
}
