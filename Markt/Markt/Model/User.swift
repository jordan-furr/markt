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
        case email
    }
    var email: String
    
    init(email: String) {
        self.email = email
    }
}
