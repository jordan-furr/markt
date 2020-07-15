//
//  FirstSubcategoryTableViewController.swift
//  Markt
//
//  Created by Jordan Furr on 7/2/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class FirstSubcategoryViewController: UIViewController {
    
    var category: String?
    var subcategories: [String] = []
    var selectedSubcategory: String?
    @IBOutlet weak var tableview: UITableView!
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var classesCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var popularclassLabel: UILabel!
    @IBOutlet weak var subcategoryLabel: UILabel!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUpViews(){
        tableview.delegate = self
        tableview.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        guard let category = category else {return}
        if category == "books" {
            classesCollectionView.dataSource = self
            classesCollectionView.delegate = self
            categoryCollectionView.isHidden = false
        } else {
            classesCollectionView.isHidden = true
            popularclassLabel.isHidden = true
            
        }
    
        categoryLabel.text = category
        navigationItem.title = "Markt"
        subcategoryLabel.text = "Sort"
        switch category {
        case "furniture":
            subcategories = furnitureTypes
            categoryLabel.text = "Furniture"
        case "clothing":
            subcategories = clothingTypes
            categoryLabel.text = "Clothing"
        case "housing":
            subcategories = subletTypes
            subcategoryLabel.text = "Housing Type"
            categoryLabel.text = "Housing"
        case "tickets":
            subcategoryLabel.text = "Sports"
            categoryLabel.text = "Tickets"
            subcategories = sports
        case "free":
            subcategories = freeCategories
            categoryLabel.text = "Free"
        case "books":
            subcategoryLabel.text = "Departments"
            categoryLabel.text = "Books"
            subcategories = topDepartments
            tableview.isHidden = true
        case "electronics":
            subcategories = electronicTypes
            categoryLabel.text = "Electronics"
        case "transportation":
            subcategories = transportTypes
            categoryLabel.text = "Transportation"
        default:
            subcategories = departments
            subcategoryLabel.isHidden = true
        }
        print(subcategories.count)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecond" {
            guard let destinationVC = segue.destination as? ShopCollectionViewController, let subcategory = selectedSubcategory else {return}
            destinationVC.category = category
            destinationVC.subcategory = subcategory
        }
        if segue.identifier == "toClassNumbers" {
            guard let destinationVC = segue.destination as? ClassesTableViewController, let subcategory = selectedSubcategory else {return}
            var classNumbers: [String] = []
            var booksInDepartment: [Listing] = []
            for listing in ListingController.shared.currentCategoryLIstings {
                if listing.subcategory == subcategory {
                    if !classNumbers.contains(listing.subsubCategory) {
                        classNumbers.append(listing.subsubCategory)
                    }
                    booksInDepartment.append(listing)
                }
            }
            destinationVC.classes = classNumbers
            destinationVC.category = category
            destinationVC.subcategory = subcategory
            destinationVC.booksInDepartment = booksInDepartment
        }
        
    }
}

extension FirstSubcategoryViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return subcategories.count
        } else {
            return popularClasses.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? SubCategoryCollectionViewCell else {return UICollectionViewCell()}
            let category = subcategories[indexPath.item]
            cell.titleLabel.text = category
            cell.backgroundColor = .green
            return cell
        } else {
            guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "classCell", for: indexPath) as? ClassCollectionViewCell else {return UICollectionViewCell()}
            let classNum = popularClasses[indexPath.item]
            cell.classLabel.text = classNum
            cell.backgroundColor = .blue
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView {
            if category == "housing" {
                return CGSize(width: 190, height: 32)
            }
            return CGSize(width: 150, height: 32)
        } else {
            return CGSize(width: 140, height: 28)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tapped")
        if collectionView == categoryCollectionView {
            if category == "books"{
                selectedSubcategory = subcategories[indexPath.row]
                performSegue(withIdentifier: "toClassNumbers", sender: self)
            }
        } else {
           performSegue(withIdentifier: "toSecond", sender: self)
        }
    }
}

extension FirstSubcategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subcategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subSwipeCell", for: indexPath)
        cell.textLabel?.text = subcategories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
}
