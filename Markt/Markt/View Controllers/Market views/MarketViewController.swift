//
//  MarketViewController.swift
//  Markt
//
//  Created by Jordan Furr on 6/18/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

var categories: [String] = {
    ["books", "furniture", "electronics", "tickets", "clothing", "transportation", "free", "housing"]
}()

class MarketViewController: UIViewController {
    
    var selectedCategory: String?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var swipegesture: UISwipeGestureRecognizer!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func menuTapped(_ sender: Any) {
        print("toggle side menu")
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    //MARK: HELPERS
    
    func setUpViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        navigationItem.hidesBackButton = true
        tapGesture.cancelsTouchesInView = false
        ListingController.shared.fetchCurrentUsersListings { (result) in
            switch result {
            case .failure(let error):
                print("Could not fetch user's live listings")
                print(error, error.localizedDescription)
            case .success(let listings):
                print("live user listings fetched"); if (listings != nil) { print(listings!)}
            }
        }
        
        ListingController.shared.fetchAllListings { (result) in
            switch result {
            case .failure(let error):
                print("Could not fetch user's live listings")
                print(error, error.localizedDescription)
            case .success(let listings):
                print("live user listings fetched")
            }
        }
    }
    
    @objc func tap(sender: UITapGestureRecognizer){
        if let indexPath = self.collectionView?.indexPathForItem(at: sender.location(in: self.collectionView)) {
            let category = categories[indexPath.item]
            selectedCategory = category
            let listings = ListingController.shared.fetchListingsInCategory(category: category)
            ListingController.shared.currentCategoryLIstings = listings
            performSegue(withIdentifier: "toSubCategories", sender: self)
//            if category == "electronics" || category == "free" || category == "transportation" {
//                performSegue(withIdentifier: "straightToShop", sender: self)
//            } else {
//                performSegue(withIdentifier: "toSubCategories", sender: self)
//            }
        } else {
            print("collection view was tapped")
        }
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func swipedLeftToMenu(_ sender: Any) {
        menuTapped(self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        swipegesture.isEnabled = false
        if segue.identifier == "toSubCategories"  {
            guard let destinationVC = segue.destination as? FirstSubcategoryViewController else {return}
            destinationVC.category = selectedCategory ?? "error"
        }
        if segue.identifier == "straightToShop"  {
            guard let destinationVC = segue.destination as? ShopCollectionViewController else {return}
            destinationVC.category = selectedCategory ?? "error"
        }
    }
    
    
}

extension MarketViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? CategoryCollectionViewCell else {return UICollectionViewCell()}
        
        let category = categories[indexPath.item]
        cell.setCategory(category: category)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 85, height: 85)
    }
    
}
