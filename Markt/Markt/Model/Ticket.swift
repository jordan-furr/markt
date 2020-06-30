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
        case opponent, gameDate
    }
    
    var opponent: String
    var gameDate: Date
    
    init(sport: String, gameDate: Date, price: Double, description: String, ownerUID: String, iconPhotoID: String, opponent: String) {
        self.opponent = opponent
        self.gameDate = gameDate
        super.init(title: (opponent + " " + sport), subtitle: sport, price: price, description: description, ownerUID: ownerUID, iconPhotoID: iconPhotoID, category: "tickets")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
