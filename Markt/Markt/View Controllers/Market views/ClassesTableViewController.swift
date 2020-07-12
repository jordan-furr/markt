//
//  ClassesTableViewController.swift
//  Markt
//
//  Created by Jordan Furr on 7/6/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class ClassesTableViewController: UITableViewController {

    var category: String?
    var subcategory: String?
    var classes: [String] = []
    var booksInDepartment: [Listing] = []
    var selectedClassNumber: String?
    
    
    override func viewWillAppear(_ animated: Bool) {
        classes = classes.sorted(by: { (a, b) -> Bool in
           return a < b
        })
        super.viewWillAppear(true)
        tableView.reloadData()
     
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if classes.count == 0 {
            presentNoListingsAlert()
        }
        navigationItem.title = subcategory
        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = classes[indexPath.row]
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedClassNumber = classes[indexPath.row]
        performSegue(withIdentifier: "toShop", sender: nil)
    }
    
    func presentNoListingsAlert() {
        let alertController = UIAlertController(title: "Oops!", message: "There are not any listings posted here yet!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            self.navigationController?.navigationController?.popViewController(animated: true)
               })
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toShop"{
            guard let destinationVC = segue.destination as? ShopCollectionViewController else {return}
            let selectedClass = selectedClassNumber ?? ""
            var booksInClass: [Listing] = []
            for book in booksInDepartment {
                if book.subsubCategory == selectedClass {
                    booksInClass.append(book)
                }
            }
            destinationVC.listings = booksInClass
        }
    }

}
