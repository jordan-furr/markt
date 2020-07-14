//
//  ListingPrevCollectionViewCell.swift
//  Markt
//
//  Created by Jordan Furr on 7/14/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class ListingPrevCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var listingImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var listing: Listing?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setListing(listing: Listing){
        self.listing = listing
        updateUI()
    }
    
    func updateUI(){
        guard let listing = listing else {return}
        if listing.images.count == 0 {
            listingImage.image = UIImage(named: listing.category)
        } else {
            listingImage.image = listing.images[0]
        }
        titleLabel.text = listing.title
        priceLabel.text = "\(listing.price)"
        listingImage.contentMode = .scaleAspectFill
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        backgroundColor = .white // very important
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
    }
    
}
