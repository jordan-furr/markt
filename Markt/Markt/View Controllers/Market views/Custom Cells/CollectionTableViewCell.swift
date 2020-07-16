//
//  CollectionTableViewCell.swift
//  Markt
//
//  Created by Jordan Furr on 7/8/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewOnCell.dequeueReusableCell(withReuseIdentifier: "listingCell", for: indexPath as IndexPath) as! ListingPrevCollectionViewCell
       let listing = Listing(title: "test", subcategory: "MATH", subsubCategory: "116", price: 3.45, description: "", ownerUID: UserController.shared.currentUser!.uid, iconPhotoID: "", category: "books")
                         listing.imageURLS = ["https://firebasestorage.googleapis.com/v0/b/markt-246fa.appspot.com/o/7CbokXFlX5Q5TH22tT0BRymZcqC2%2F2371F504-ACDA-46BD-BA4F-E11D120D6E9F%2F208794C7-BD10-4531-8BE5-2D8E314B6648?alt=media&token=de3d0f5f-7607-4f8e-bc1a-d04eabe7167d"]
        cell.setListing(listing: listing)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 140)
    }
    
    var collectionViewOffset: CGFloat {
        get {
            return collectionViewOnCell.contentOffset.x
        }
        
        set {
            collectionViewOnCell.contentOffset.x = newValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionViewOnCell.dataSource = self
        self.collectionViewOnCell.delegate = self
        self.collectionViewOnCell.register(UINib(nibName: "ListingPrevCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "listingCell")
    }
    
    override func layoutSubviews() {
           super.layoutSubviews()
           backgroundColor = .clear
        collectionViewOnCell.backgroundColor = .clear
       }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet private weak var collectionViewOnCell: UICollectionView!
}
