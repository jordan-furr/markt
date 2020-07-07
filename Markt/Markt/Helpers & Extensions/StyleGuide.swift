//
//  StyleGuide.swift
//  Markt
//
//  Created by Jordan Furr on 6/27/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    
    func addCornerRadius(_ radius: CGFloat = 8) {
        self.layer.cornerRadius = radius
    }
}

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}

extension UIColor {
    static let customGreen = UIColor(named: "butterflyGreen")
    static let lightGreen = UIColor(named: "loginGreen")
    static let darkGreen = UIColor(named: "loginDarkGreen")
    static let limeYellow = UIColor(named: "customYellow")
    
    static func random() -> UIColor {
           return UIColor(
              red:   .random(),
              green: .random(),
              blue:  .random(),
              alpha: 1.0
           )
       }
}

extension UILabel {
    
    func addLocationColoringAndText(user: User){
        
        switch (user.campusLocation) {
        case 0:
            self.text = "Not Specified"
            self.backgroundColor = .red
            self.textColor = .white
            break
        case 1:
            self.text = "Central Campus"
            self.backgroundColor = .systemTeal
            self.textColor = .black
            break
        case 2:
            self.text = "South Campus"
            self.backgroundColor = .green
            self.textColor = .black
            break
        case 3:
            self.text = "North Campus"
            self.backgroundColor = .orange
            self.textColor = .black
        default:
            self.text = "Error"
            break
        }
        
    }
    
    func addDropOffColoringAndText(user: User) {
        if (user.dropOff == true) {
            self.text = "Willing to drop"
            self.backgroundColor = .blue
            self.textColor = .white
        } else {
            self.text = "Pickup only"
            self.backgroundColor = .yellow
            self.textColor = .black
        }
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
