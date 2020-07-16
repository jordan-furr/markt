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
        ListingController.shared.allListings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewOnCell.dequeueReusableCell(withReuseIdentifier: "listingCell", for: indexPath as IndexPath) as! ListingPrevCollectionViewCell
        let listing = ListingController.shared.allListings[indexPath.row]
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
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet private weak var collectionViewOnCell: UICollectionView!
}
