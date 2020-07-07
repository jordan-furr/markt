//
//  Sublet.swift
//  Markt
//
//  Created by Jordan Furr on 6/30/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation

class Sublet : Listing {
    
    enum CodingKeys: String, CodingKey {
        case subletType
    }
    
    var subletType: String
    
    init(title: String, subtitle: String, subletType: String, price: Double, description: String, ownerUID: String, iconPhotoID: String, date: Date) {
        self.subletType = subletType
        super.init(title: title, subtitle: subtitle, price: price, description: description, ownerUID: ownerUID, iconPhotoID: iconPhotoID, category: "housing")
        self.date = date
    }
    
    required init(from decoder: Decoder) throws {
     fatalError("init(from:) has not been implemented")
    }
}
