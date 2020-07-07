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

var departments: [String] = {
    ["MATH", "AMCULT", "ENGLISH", "ECON", "POLYSCI", "PSYCH", "EECS"]
}()

var furnitureTypes: [String] = {
    ["Couch", "Bed", "Chair", "Desk", "Table", "Light", "Beanbag"]
}()

var sizes: [String] = {
    ["XXS", "XS", "S", "M", "L", "XL", "XXL", "XXXL"]
}()

var subletTypes: [String] = {
    ["Private Room", "Entire Aparmtent", "Entire House", "Shared Room", "Other"]
}()

var sports: [String] = {
    ["Football", "Basketball", "Hockey", "Soccer", "Tennis"]
}()

var popularClasses: [String] = {
    ["Econ 101", "Econ 102", "Math 115", "Psych 211", "COMM 102"]
}()

var freeCategories: [String] = {
    ["Books", "Furniture", "Electronics", "Tickets", "Clothing", "Transportation"]
}()


class Listing: Codable {
    
    enum CodingKeys: String, CodingKey {
        case uid, title, price, description, ownerUID, iconPhotoID, category, subcategory, subsubCategory
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
    
    var iconPhotoID: String
    var iconImage: UIImage? = nil
    var iconImageData: Data? {
        guard let iconImage = iconImage else { return nil }
        return iconImage.jpegData(compressionQuality: 0.5)
    }
    
    init(title: String, subcategory: String, subsubCategory: String, price: Double, description: String, ownerUID: String, iconPhotoID: String, category: String) {
        self.uid = UUID().uuidString
        self.title = title
        self.subsubCategory = subsubCategory
        self.subcategory = subcategory
        self.price = price
        self.description = description
        self.ownerUID = ownerUID
        self.iconPhotoID = iconPhotoID
        self.category = category
    }
}
