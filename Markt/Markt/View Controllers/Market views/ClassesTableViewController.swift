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
    var classes: [Int] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1)"
        return cell
    }
    
    func presentNoListingsAlert() {
        let alertController = UIAlertController(title: "Oops!", message: "There are not any listings posted here yet!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }

}
