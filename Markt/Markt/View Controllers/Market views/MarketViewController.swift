//
//  MarketViewController.swift
//  Markt
//
//  Created by Jordan Furr on 6/18/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit


class MarketViewController: UIViewController {
    
    //MARK: - Properties
    var selectedCategory: String?
    
    //MARK: - IB OUTELTS
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    //MARK: - Life Cycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - IB Actions
    @IBAction func menuTapped(_ sender: Any) { NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil) }
    @IBAction func backgroundTapped(_ sender: Any) { self.view.endEditing(true)}
    @IBAction func swipedLeft(_ sender: Any) {menuTapped(true)}
    
    
    //MARK: HELPERS
    func setUpViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        navigationItem.hidesBackButton = true
        tapGesture.cancelsTouchesInView = false
        
        ListingController.shared.fetchCurrentUsersListings { (result) in
            print(result)
        }
    }
    
    @objc func tap(sender: UITapGestureRecognizer){
        if let indexPath = self.collectionView?.indexPathForItem(at: sender.location(in: self.collectionView)) {
            let category = categories[indexPath.item]
            selectedCategory = category
            let listings = ListingController.shared.fetchListingsInCategory(category: category)
            ListingController.shared.currentCategoryLIstings = listings
            performSegue(withIdentifier: "toSubCategories", sender: self)
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSubCategories"  {
            guard let destinationVC = segue.destination as? FirstSubcategoryViewController else {return}
            destinationVC.category = selectedCategory ?? "error"
        }
    }
}

    //MARK: - Top 8 Category Collection view
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
        return CGSize(width: 72, height: 72)
    }
}
