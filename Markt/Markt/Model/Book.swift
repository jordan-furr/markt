//
//  Book.swift
//  Markt
//
//  Created by Jordan Furr on 6/29/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit
import Foundation

class Book : Listing {
    
    enum CodingKeys: String, CodingKey {
        case department, classNumber
    }
    
    var department: String
    var classNumber: String
    
    init(title: String, subtitle: String, price: Double, description: String, ownerUID: String, iconPhotoID: String, department: String, classNumber: String) {
        self.department = department
        self.classNumber = classNumber
        super.init(title: title, subtitle: subtitle, price: price, description: description, ownerUID: ownerUID, iconPhotoID: iconPhotoID, category: "books")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
