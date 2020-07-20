//
//  ShopCollectionViewController.swift
//  Markt
//
//  Created by Jordan Furr on 7/3/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class ShopCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Properties
    var listings: [Listing] = []
    var category: String?
    var subcategory: String?
    
    //MARK: - IB OUTLETS
    
    //MARK: - Life Cycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        ListingController.shared.loadAllListings {
            self.collectionView.reloadData()
        }
        listings = ListingController.shared.allListings
        setUpViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    //MARK: - Collection View delegate/data source functions
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listings.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "listingCell", for: indexPath) as! ListingPrevCollectionViewCell
        let listing = listings[indexPath.row]
        cell.setListing(listing: listing)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 140)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ListingPrevCollectionViewCell
        performSegue(withIdentifier: "toListingDetail", sender: cell)
    }
    
    //MARK: - Helpers:
    func setUpViews(){
        navigationItem.title = "Markt"
        collectionView.delegate = self
        collectionView.dataSource = self
        if listings.count == 0 { presentNoListingsAlert()}
        collectionView.register(UINib(nibName: "ListingPrevCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "listingCell")
    }
    
    func presentNoListingsAlert() {
        let alertController = UIAlertController(title: "Oops!", message: "Looks like there aren't any listings posted here yet!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? ListingPrevCollectionViewCell,
            let indexPath = self.collectionView.indexPath(for: cell) {
            let vc = segue.destination as! ListingDetailViewController
            let listing = listings[indexPath.row] as Listing
            vc.listing = listing
        }
    }
}
