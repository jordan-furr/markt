//
//  CollectionTableViewCell.swift
//  Markt
//
//  Created by Jordan Furr on 7/8/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var listings: [Listing] = []
    //FILLED WITH DUMMY VALUES
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewOnCell.dequeueReusableCell(withReuseIdentifier: "listingCell", for: indexPath as IndexPath) as! ListingPrevCollectionViewCell
        let listing = listings[indexPath.row]
        cell.setListing(listing: listing)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 180)
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
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8))
//        contentView.layer.cornerRadius = 8
//        layer.masksToBounds = false
//        layer.shadowOpacity = 0.23
//        layer.shadowRadius = 3
//        layer.shadowOffset = CGSize(width: 0, height: 0)
//        layer.shadowColor = UIColor.black.cgColor
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet private weak var collectionViewOnCell: UICollectionView!
}
