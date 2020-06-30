//
//  Listing.swift
//  Markt
//
//  Created by Jordan Furr on 6/9/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit
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

struct Category8Keys {
    static let booksKey = "books"
    static let furnitureKey = "furniture"
    static let electronicsKey = "electronics"
    static let ticketsKey = "tickets"
    static let clothingKey = "clothing"
    static let transpotationKey = "transportaion"
    static let freeKey = "free"
    static let housingKey = "housing"
}

class Listing: Codable {
    
    enum CodingKeys: String, CodingKey {
        case uid, title, subtitle, price, description, ownerUID, iconPhotoID, category
    }
    var uid: String
    var title: String
    var subtitle: String
    var price: Double
    var description: String
    var ownerUID: String
    var category: String
    
    var iconPhotoID: String
    var iconImage: UIImage? = nil
    var iconImageData: Data? {
        guard let iconImage = iconImage else { return nil }
        return iconImage.jpegData(compressionQuality: 0.5)
    }
    
    init(title: String, subtitle: String, price: Double, description: String, ownerUID: String, iconPhotoID: String, category: String) {
        self.uid = UUID().uuidString
        self.title = title
        self.subtitle = subtitle
        self.price = price
        self.description = description
        self.ownerUID = ownerUID
        self.iconPhotoID = iconPhotoID
        self.category = category
    }
}
