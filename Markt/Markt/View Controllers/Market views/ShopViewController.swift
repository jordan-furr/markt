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
            self.listings = ListingController.shared.allListings
        }
        setUpViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUpViews(){
        navigationItem.title = "Markt"
        if subsubcategory != nil {
            subsubCategoryLabel.text = subsubcategory
        } else if subcategory != nil {
            subsubCategoryLabel.text = subcategory
        } else {
            subsubCategoryLabel.text = category
        }
        shopCollectionView.delegate = self
        shopCollectionView.dataSource = self
        if listings.count == 0 { presentNoListingsAlert()}
        shopCollectionView.register(UINib(nibName: "ListingPrevCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "listingCell")
    }
    
    func presentNoListingsAlert() {
        let alertController = UIAlertController(title: "Oops!", message: "Looks like there aren't any listings posted here yet!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
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
        return CGSize(width: 110, height: 140)
    }
    
}
