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
        listing.imageURLS = ["https://firebasestorage.googleapis.com/v0/b/markt-246fa.appspot.com/o/iahlkTN86TRukXmAdo7eJgZ5kwZ2%2FBF2A9F4B-DC65-4865-BAFB-AE9C56F39A41%2F1E5979E6-5188-43E3-BFCA-FB63B88C8888?alt=media&token=7ebca3ac-7862-4653-818a-e7fd5c891aa3"]
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
