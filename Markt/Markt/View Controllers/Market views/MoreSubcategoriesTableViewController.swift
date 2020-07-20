//
//  MoreSubcategoriesTableViewController.swift
//  Markt
//
//  Created by Jordan Furr on 7/15/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class MoreSubcategoriesTableViewController: UITableViewController {

    //MARK: Properties
    var category: String?
    var moreCategories: [String] = []
    var selectedSubcategory: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moreCategories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCell", for: indexPath)
        cell.textLabel?.text = moreCategories[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSubcategory = moreCategories[indexPath.row]
        if category == "books"{
            self.performSegue(withIdentifier: "toClasses", sender: self)
        } else {
            self.performSegue(withIdentifier: "toShop", sender: self)
        }
    }

    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let subcategory = selectedSubcategory else {return}
        
        if segue.identifier == "toClasses"{
            guard let destinationVC = segue.destination as? ClassesTableViewController else {return}
            var classNumbers: [String] = []
            var booksInDepartment: [Listing] = []
            
            //FIXME --- SAME AS ON FIRST SUBCAT VC
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
        if segue.identifier == "toShop"{
             guard let destinationVC = segue.destination as? ShopViewController else {return}
                destinationVC.category = category
                destinationVC.subcategory = subcategory
        }
    }
}
