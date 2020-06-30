//
//  ClothingItem.swift
//  Markt
//
//  Created by Jordan Furr on 6/30/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit
import Foundation

class ClothingItem : Listing {
    
    enum CodingKeys: String, CodingKey {
        case size
    }
    var size: String
    
    init(title: String, subtitle: String, price: Double, description: String, ownerUID: String, iconPhotoID: String, size: String) {
        self.size = size
        super.init(title: title, subtitle: subtitle, price: price, description: description, ownerUID: ownerUID, iconPhotoID: iconPhotoID, category: "clothing")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
