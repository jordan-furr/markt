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
        case uid, email, firstName, lastName, campusLocation, myListings, savedListings
    }
    
    var uid: String
    var email: String
    var firstName: String
    var lastName: String
    var campusLocation: Int = 0
    var dropOff: Bool = false
    var myListings: [String]
    var savedListings: [String]
    
    init(email: String, firstName: String, lastName: String, uid: String, myListings: [String], savedListings: [String]) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.uid = uid
        self.myListings = myListings
        self.savedListings = savedListings
    }
}
