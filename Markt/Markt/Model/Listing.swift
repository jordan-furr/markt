//
//  Listing.swift
//  Markt
//
//  Created by Jordan Furr on 6/9/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit
import CodableFirebase
import Foundation




class Listing: Codable {
    
    enum CodingKeys: String, CodingKey {
        case uid, title, price, description, ownerUID, category, subcategory, subsubCategory, imageURLS
    }
    var uid: String
    var title: String
    var category: String
    var subcategory: String = ""
    var subsubCategory: String = "" //class Number for books, size for clothes, opponent for ticket
    var price: Double
    var description: String
    var ownerUID: String
    var date: Date = Date()
    var imageURLS: [String] = []
    
    init(title: String, subcategory: String, subsubCategory: String, price: Double, description: String, ownerUID: String, category: String) {
        self.uid = UUID().uuidString
        self.title = title
        self.subsubCategory = subsubCategory
        self.subcategory = subcategory
        self.price = price
        self.description = description
        self.ownerUID = ownerUID
        self.category = category
        self.date = Date()
    }
}
