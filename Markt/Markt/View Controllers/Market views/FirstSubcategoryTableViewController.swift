//
//  FirstSubcategoryTableViewController.swift
//  Markt
//
//  Created by Jordan Furr on 7/2/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class FirstSubcategoryViewController: UIViewController {
    
    //MARK: - Properties
    var category: String?
    var subcategories: [String] = []
    var selectedSubcategory: String?
    var storedOffsets = [Int: CGFloat]()
    
    //MARK: - IB OUTLETS
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var classesCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var popularclassLabel: UILabel!
    @IBOutlet weak var subcategoryLabel: UILabel!
    
    //MARK: - Life Cycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Helpers
    @objc func subCategoryLabelMoreTapped(_ sender: UITapGestureRecognizer){
        performSegue(withIdentifier: "toMore", sender: self)
    }
    
    func setUpViews(){
        guard let category = category else {return}
        tableview.reloadData()
//        ListingController.shared.loadListingsInCategory(category: category) {
//            self.tableview.reloadData()
//        }
        setUpTapRecognizerAndDelegates(category)
        categoryLabel.text = category
        navigationItem.title = "Markt"
        subcategoryLabel.text = "More"
        
        switch category {
        case "furniture":
            subcategories = furnitureTypes
            categoryLabel.text = "Furniture"
            subcategoryLabel.text = subcategoryLabel.text! + " >"
            subcategoryLabel.isUserInteractionEnabled = true
        case "clothing":
            subcategories = clothingTypes
            categoryLabel.text = "Clothing"
            subcategoryLabel.text = subcategoryLabel.text! + " >"
            subcategoryLabel.isUserInteractionEnabled = true
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
            subcategoryLabel.text = subcategoryLabel.text! + " >"
            subcategoryLabel.isUserInteractionEnabled = true
        case "electronics":
            subcategories = electronicTypes
            categoryLabel.text = "Electronics"
            subcategoryLabel.text = subcategoryLabel.text! + " >"
            subcategoryLabel.isUserInteractionEnabled = true
        case "transportation":
            subcategories = transportTypes
            categoryLabel.text = "Transportation"
        default:
            subcategories = departments
            subcategoryLabel.isHidden = true
        }
    }
    
    func setUpTapRecognizerAndDelegates(_ category: String){
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(subCategoryLabelMoreTapped(_:)))
        subcategoryLabel.isUserInteractionEnabled = false
        subcategoryLabel.addGestureRecognizer(labelTap)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: "CollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "scrollCell")
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        if category == "books" {
            classesCollectionView.dataSource = self
            classesCollectionView.delegate = self
            categoryCollectionView.isHidden = false
        } else {
            classesCollectionView.isHidden = true
            popularclassLabel.isHidden = true
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let category = category, let subcategory = selectedSubcategory else {return}
        
        if segue.identifier == "toSecond" {
            guard let destinationVC = segue.destination as? ShopViewController else {return}
            destinationVC.category = category
            destinationVC.subcategory = subcategory
        }
        
        if segue.identifier == "toClassNumbers" {
            guard let destinationVC = segue.destination as? ClassesTableViewController else {return}
            //FIXME
            //FETCH BOOKS AND CLASS NUMBERS
            var classNumbers: [String] = []
            var booksInDepartment: [Listing] = []
            //FIXME SUBSUB LISTINGS IN SUBCATEGORY
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
        
        if segue.identifier == "toMore"{
            guard let desinationVC = segue.destination as? MoreSubcategoriesTableViewController else {return}
            desinationVC.category = category
            switch category {
            case "books":
                desinationVC.moreCategories = departments
            default:
                desinationVC.moreCategories = subcategories
                return
            }
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
            return cell
        } else {
            guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "classCell", for: indexPath) as? ClassCollectionViewCell else {return UICollectionViewCell()}
            let classNum = popularClasses[indexPath.item]
            cell.classLabel.text = classNum
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
        if collectionView == categoryCollectionView {
            if category == "books"{
                selectedSubcategory = subcategories[indexPath.row]
                performSegue(withIdentifier: "toClassNumbers", sender: self)
            } else {
                selectedSubcategory = subcategories[indexPath.row]
                performSegue(withIdentifier: "toSecond", sender: self)
            }
        } else {
            performSegue(withIdentifier: "toSecond", sender: self)
        }
    }
}

//Table View delegate and data source funcs
extension FirstSubcategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subcategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "scrollCell", for: indexPath) as? CollectionTableViewCell else {return UITableViewCell()}
        cell.categoryLabel.text = subcategories[indexPath.row]
        let subCategoryListings: [Listing] = ListingController.shared.currentCategoryLIstings
        cell.listings = subCategoryListings
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? CollectionTableViewCell else {return}
        cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? CollectionTableViewCell else {return}
        storedOffsets[indexPath.row] = cell.collectionViewOffset
    }
}
