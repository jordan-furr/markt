//
//  User.swift
//  Markt
//
//  Created by Jordan Furr on 6/9/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit
import Foundation

class User: Codable {
    
    enum CodingKeys: String, CodingKey {
        case email, firstName, lastName
    }
    var email: String
    var firstName: String
    var lastName: String
    var CampusLocation: String = ""
    
    init(email: String, firstName: String, lastName: String) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
    }
}
