//
//  Listing.swift
//  Markt
//
//  Created by Jordan Furr on 6/9/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit
import Foundation

class Listing: Codable {
    
    enum CodingKeys: String, CodingKey {
        case title, price, description, ownerUID, iconPhotoID
    }
    
    var title: String
    var price: Double
    var description: String
    var ownerUID: String
    
    var iconPhotoID: String
    var profileImage: UIImage? = nil
    var profileImageData: Data? {
        guard let profileImage = profileImage else { return nil }
        return profileImage.jpegData(compressionQuality: 0.5)
    }
    
    init(title: String, price: Double, description: String, ownerUID: String, iconPhotoID: String) {
        self.title = title
        self.price = price
        self.description = description
        self.ownerUID = ownerUID
        self.iconPhotoID = iconPhotoID
    }
}
