//
//  ShopCollectionViewController.swift
//  Markt
//
//  Created by Jordan Furr on 7/3/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

private let reuseIdentifier = "itemCell"

class ShopCollectionViewController: UICollectionViewController {
    
    var category: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setUpViews(){
        guard let category = category else {return}
        navigationItem.title = category
        
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ListingController.shared.currentUserLiveListings.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "listingCell", for: indexPath) as? ListingCollectionViewCell else {return UICollectionViewCell()}
        let listing = ListingController.shared.currentUserLiveListings[indexPath.row]
        cell.setListing(listing: listing)
        cell.layer.borderWidth = 1.4
        cell.layer.borderColor = .init(srgbRed: 4, green: 4, blue: 4, alpha: 4)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    
}
