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
        case uid, email, firstName, lastName, campusLocation, profilePicUID, myListings, savedListings
    }
    
    var uid: String
    var email: String
    var firstName: String
    var lastName: String
    var campusLocation: Int = 0
    var dropOff: Bool = false
    
    var profilePicUID: String
    var profileImage: UIImage? = nil
    var profileImageData: Data? {
        guard let profileImage = profileImage else { return nil }
        return profileImage.jpegData(compressionQuality: 0.5)
    }
    
    var myListings: [String]
    var savedListings: [String]
    
    init(email: String, firstName: String, lastName: String, uid: String, profilePicUID: String, myListings: [String], savedListings: [String]) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.uid = uid
        self.profilePicUID = profilePicUID
        self.myListings = myListings
        self.savedListings = savedListings
    }
}
