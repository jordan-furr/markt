//
//  ShopCollectionViewController.swift
//  Markt
//
//  Created by Jordan Furr on 7/3/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

private let reuseIdentifier = "itemCell"

class ShopCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var category: String?
    var subcategory: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(ListingCollectionViewCell.self.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setUpViews(){
        guard let category = category else {return}
        navigationItem.title = category
        
    }
    

       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              
              if let cell = sender as? ListingCollectionViewCell,
                  let indexPath = self.collectionView.indexPath(for: cell) {
                  let vc = segue.destination as! ListingDetailViewController
                  let listing = ListingController.shared.currentUserLiveListings[indexPath.row] as Listing
                  vc.listing = listing
              }
          }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ListingController.shared.currentCategoryLIstings.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as? ListingCollectionViewCell else {return UICollectionViewCell()}
        let listing = ListingController.shared.currentCategoryLIstings[indexPath.row]
        cell.setListing(listing: listing)
        cell.backgroundColor = .lightGray
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ListingCollectionViewCell
        performSegue(withIdentifier: "toListingDetail", sender: cell)
    }
    
}
