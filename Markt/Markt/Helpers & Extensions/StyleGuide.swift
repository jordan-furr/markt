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
}
