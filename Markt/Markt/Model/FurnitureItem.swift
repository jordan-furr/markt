//
//  FurnitureItem.swift
//  Markt
//
//  Created by Jordan Furr on 6/30/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit
import Foundation

class FurnitureItem : Listing {
    
    enum CodingKeys: String, CodingKey {
        case type
    }
    
    var type: String
    
    init(title: String, subtitle: String, price: Double, description: String, ownerUID: String, iconPhotoID: String, type: String) {
        self.type = type
        super.init(title: title, subtitle: subtitle, price: price, description: description, ownerUID: ownerUID, iconPhotoID: iconPhotoID, category: "furniture")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
