//
//  ShopViewController.swift
//  Markt
//
//  Created by Jordan Furr on 7/20/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {

    @IBOutlet weak var subsubCategoryLabel: UILabel!
    @IBOutlet weak var shopCollectionView: UICollectionView!
    
    var listings: [Listing] = []
    var category: String?
    var subcategory: String?
    var subsubcategory: String?
    
    override func viewWillAppear(_ animated: Bool) {
        ListingController.shared.loadAllListings {
            self.shopCollectionView.reloadData()
        }
        self.listings = ListingController.shared.allListings
        self.listings = ListingController.shared.returnListingsInSubCategory(listings: listings, subcategory: subcategory!)
        setUpViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUpViews(){
        navigationItem.title = "Markt"
        if subsubcategory != nil {
            subsubCategoryLabel.text = subsubcategory
        } else {
            subsubCategoryLabel.text = subcategory
        }
        
        shopCollectionView.delegate = self
        shopCollectionView.dataSource = self
        shopCollectionView.register(UINib(nibName: "ListingPrevCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "listingCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? ListingPrevCollectionViewCell,
            let indexPath = self.shopCollectionView.indexPath(for: cell) {
            let vc = segue.destination as! ListingDetailViewController
            let listing = listings[indexPath.row] as Listing
            vc.listing = listing
        }
    }

}

extension ShopViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "listingCell", for: indexPath) as! ListingPrevCollectionViewCell
        let listing = listings[indexPath.row]
        cell.setListing(listing: listing)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ListingPrevCollectionViewCell
        performSegue(withIdentifier: "toListingDetail", sender: cell)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 200)
    }
    
}
