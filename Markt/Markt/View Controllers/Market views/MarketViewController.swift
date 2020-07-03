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
    //MARK: - IB OUTLETS
    @IBOutlet weak var collectionView: UICollectionView!
    
    
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
        navigationItem.hidesBackButton = true
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showProfile),
                                               name: NSNotification.Name("ShowProfile"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showSettings),
                                               name: NSNotification.Name("ShowSettings"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showAbout),
                                               name: NSNotification.Name("ShowAbout"),
                                               object: nil)
        ListingController.shared.fetchCurrentUsersListings { (result) in
            switch result {
            case .failure(let error):
                print("Could not fetch user's live listings")
                print(error, error.localizedDescription)
            case .success(let listings):
                print("live user listings fetched"); if (listings != nil) { print(listings!)}
            }
        }
        
        
    }
    @objc func showProfile() {
        performSegue(withIdentifier: "ShowProfile", sender: nil)
    }
    @objc func showSettings() {
        performSegue(withIdentifier: "ShowSettings", sender: nil)
    }
    @objc func showAbout() {
        performSegue(withIdentifier: "ShowAbout", sender: nil)
    }
    
    @IBAction func imageTapped(_ sender: Any) {
        performSegue(withIdentifier: "toSubCategories", sender: self)
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        self.view.endEditing(true)
        if sideMenuOpen {
            menuTapped(true)
            sideMenuOpen = false
        }
        
    }
    
    @IBAction func swipedLeftToMenu(_ sender: Any) {
        menuTapped(self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSubCategories" {
            guard let destinationVC = segue.destination as? FirstSubcategoryTableViewController else {return}
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
        cell.layer.borderColor = CGColor(srgbRed: 4, green: 4, blue: 4, alpha: 4)
        cell.layer.borderWidth = 2
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 85, height: 85)
       }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.item]
        selectedCategory = category
        performSegue(withIdentifier: "toSubCategories", sender: self)
        print("tapped cell")
    }
}
