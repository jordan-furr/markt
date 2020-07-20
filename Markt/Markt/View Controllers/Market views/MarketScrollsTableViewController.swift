//
//  MarketScrollsTableViewController.swift
//  Markt
//
//  Created by Jordan Furr on 7/15/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class MarketScrollsTableViewController: UITableViewController {

    //MARK: - Properties
    var storedOffsets = [Int: CGFloat]()
    
    //MARK: - Life Cycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - Helpers
    func setUpViews(){
        ListingController.shared.loadAllListings {
            self.tableView.reloadData()
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "scrollCell")
    }
    
    //MARK: - Tableview delegate/data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "scrollCell", for: indexPath) as? CollectionTableViewCell else {return UITableViewCell()}
        cell.categoryLabel.text = "All Listings"
        cell.listings = ListingController.shared.allListings
        return cell
    }
    
    //MARK: - TableView Style
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? CollectionTableViewCell else {return}
        cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? CollectionTableViewCell else {return}
        storedOffsets[indexPath.row] = cell.collectionViewOffset
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240.0
    }
}
