//
//  ListingCollectionViewCell.swift
//  Markt
//
//  Created by Jordan Furr on 6/28/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class ListingCollectionViewCell: UICollectionViewCell {
    
    var listing: Listing?
    
    fileprivate let bg: UIImageView = {
          let iv = UIImageView()
           iv.translatesAutoresizingMaskIntoConstraints = false
           iv.contentMode = .center
           iv.clipsToBounds = true
                   iv.layer.cornerRadius = 12
           return iv
       }()
       
       override init(frame: CGRect) {
           super.init(frame: .zero)
           


           
           contentView.addSubview(bg)

           bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
           bg.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
           bg.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
           bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

       }
       
    func encodeWithCoder(_ aCoder: NSCoder) {
           // Serialize your object here
       }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
       }
    
    func setListing(listing: Listing){
        self.listing = listing
        updateUI()
    }
    
    func updateUI(){
        guard let listing = listing else {return}
        bg.image = UIImage(named: listing.category)
       
    }
}
