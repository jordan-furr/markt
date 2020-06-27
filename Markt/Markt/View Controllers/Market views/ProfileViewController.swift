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
    
    
    override func viewWillAppear(_ animated: Bool) {
        setUpViews()
        collectionView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setUpViews() {
        guard let user = UserController.shared.currentUser else {return}
        nameLabel.text = user.firstName + " " + user.lastName
        switch (user.campusLocation) {
        case 0:
            locationLabel.text = "Not Specified"
            break
        case 1:
            locationLabel.text = "Central Campus"
            break
        case 2:
            locationLabel.text = "South Campus"
            break
        case 3:
            locationLabel.text = "North Campus"
        default:
            locationLabel.text = "Error"
            break
        }
        if (user.dropOff) {
            dropOffBool.text = "Willing to drop"
        } else {
            dropOffBool.text = "Pickup only"
        }
    }
}


extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int.random(in: 1 ..< 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "listingCell", for: indexPath)
        return cell
    }
}
