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
        case uid, title, subtitle, price, description, ownerUID, iconPhotoID
    }
    var uid: String
    var title: String
    var subtitle: String
    var price: Double
    var description: String
    var ownerUID: String
    
    var iconPhotoID: String
    var iconImage: UIImage? = nil
    var iconImageData: Data? {
        guard let iconImage = iconImage else { return nil }
        return iconImage.jpegData(compressionQuality: 0.5)
    }
    
    init(title: String, subtitle: String, price: Double, description: String, ownerUID: String, iconPhotoID: String) {
        self.uid = UUID().uuidString
        self.title = title
        self.subtitle = subtitle
        self.price = price
        self.description = description
        self.ownerUID = ownerUID
        self.iconPhotoID = iconPhotoID
    }
}
