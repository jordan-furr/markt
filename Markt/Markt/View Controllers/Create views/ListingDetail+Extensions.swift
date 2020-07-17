//
//  ListingDetail+Extensions.swift
//  Markt
//
//  Created by Jordan Furr on 7/17/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

extension ListingDetailViewController{
    
    func setDateLabelWithListingID(listing: Listing){
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        ListingController.shared.fetchDate(listingUID: listing.uid, completion: { (result) in
            switch result {
            case .success(let date):
                guard let date = date else {return}
                let dateString = df.string(from: date)
                if listing.category == "housing" {
                    self.dateLabel.text = "Available: " + dateString
                } else {
                    self.dateLabel.text = "Game Date: " + dateString
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        })
    }
}
