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
        case opponent
    }
    
    var opponent: String
    
    init(sport: String, price: Double, description: String, ownerUID: String, iconPhotoID: String, opponent: String, gameDate: Date) {
        self.opponent = opponent
        super.init(title: (opponent + " " + sport), subtitle: sport, price: price, description: description, ownerUID: ownerUID, iconPhotoID: iconPhotoID, category: "tickets")
        date = gameDate
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
