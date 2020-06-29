//
//  Ticket.swift
//  Markt
//
//  Created by Jordan Furr on 6/29/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation

class Ticket : Listing {
    
    enum CodingKeys: String, CodingKey {
        case gameID, section, seat, row
    }
    
    var gameID: String
    var section: String
    var seat: String
    var row: String
    
    init(title: String, subtitle: String, price: Double, description: String, ownerUID: String, iconPhotoID: String, gameID: String, section: String, seat: String, row: String) {
        self.gameID = gameID
        self.section = section
        self.seat = seat
        self.row = row
        super.init(title: title, subtitle: subtitle, price: price, description: description, ownerUID: ownerUID, iconPhotoID: iconPhotoID, category: "tickets")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
