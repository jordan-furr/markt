//
//  ListingCollectionViewCell.swift
//  Markt
//
//  Created by Jordan Furr on 6/28/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class ListingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var listing: Listing?
    
    func setListing(listing: Listing){
        self.listing = listing
        updateUI()
    }
    
    func updateUI(){
        guard let listing = listing else {return}
        titleLabel.text = listing.title
        priceLabel.text = "\(listing.price)"
        priceLabel.textColor = .red
    }
}
