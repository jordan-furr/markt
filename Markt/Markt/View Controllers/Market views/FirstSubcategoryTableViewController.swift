//
//  FirstSubcategoryTableViewController.swift
//  Markt
//
//  Created by Jordan Furr on 7/2/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class FirstSubcategoryTableViewController: UITableViewController {

    var category: String?
    var subcategories: [String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setUpViews(){
        guard let category = category else {return}
        navigationItem.title = category
        switch category {
        case "furniture":
            subcategories = furnitureTypes
            default:
            subcategories = departments
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subcategories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCatCell", for: indexPath)
        cell.textLabel?.text = subcategories[indexPath.row]
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecond" {
            guard let destinationVC = segue.destination as? ShopCollectionViewController else {return}
            destinationVC.category = category
        }
    }
}
