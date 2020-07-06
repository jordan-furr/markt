//
//  ProfileViewController.swift
//  Markt
//
//  Created by Jordan Furr on 6/27/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    //MARK: - IB OUTLETS
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dropOffBool: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var userListings: [Listing]?
    
    override func viewWillAppear(_ animated: Bool) {
        setUpViews()
        collectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ListingCollectionViewCell.self, forCellWithReuseIdentifier: "listingCell")
    }
    
    func setUpViews() {
        guard let user = UserController.shared.currentUser else {return}
        
        nameLabel.text = user.firstName + " " + user.lastName
        locationLabel.layer.cornerRadius = 8
        dropOffBool.layer.cornerRadius = 8
        locationLabel.addLocationColoringAndText(user: user)
        dropOffBool.addDropOffColoringAndText(user: user)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? ListingCollectionViewCell,
            let indexPath = self.collectionView.indexPath(for: cell) {
            let vc = segue.destination as! ListingDetailViewController
            let listing = ListingController.shared.currentUserLiveListings[indexPath.row] as Listing
            vc.listing = listing
        }
    }
    
    @IBAction func exitProfile(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ListingController.shared.currentUserLiveListings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "listingCell", for: indexPath) as? ListingCollectionViewCell else {return UICollectionViewCell()}
        let listing = ListingController.shared.currentUserLiveListings[indexPath.row]
        cell.setListing(listing: listing)
        cell.backgroundColor = .lightGray
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
              return CGSize(width: 110, height: 110)
          }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ListingCollectionViewCell
        performSegue(withIdentifier: "toListingDetail", sender: cell)
    }
    
    
}


