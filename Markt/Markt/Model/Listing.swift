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
        case uid, title, subtitle, price, description, ownerUID, iconPhotoID, willingToDeliver
    }
    
    var uid: String
    var title: String
    var subtitle: String
    var price: Double
    var description: String
    var ownerUID: String
    var willingToDeliver: Bool
    
    var iconPhotoID: String
    var profileImage: UIImage? = nil
    var profileImageData: Data? {
        guard let profileImage = profileImage else { return nil }
        return profileImage.jpegData(compressionQuality: 0.5)
    }
    
    init(uid: String, title: String, subtitle: String, price: Double, description: String, ownerUID: String, iconPhotoID: String, willingToDeliver: Bool) {
        self.uid = uid
        self.title = title
        self.subtitle = subtitle
        self.price = price
        self.description = description
        self.ownerUID = ownerUID
        self.iconPhotoID = iconPhotoID
        self.willingToDeliver = willingToDeliver
    }
}
