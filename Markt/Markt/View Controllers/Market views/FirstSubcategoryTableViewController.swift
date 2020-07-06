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
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        if category == "books" {
            classesCollectionView.dataSource = self
            classesCollectionView.delegate = self
        } else {
            classesCollectionView.isHidden = true
            popularclassLabel.isHidden = true
        }
        
        
        guard let category = category else {return}
        categoryLabel.text = category
        navigationItem.title = "Markt"
        switch category {
        case "furniture":
            subcategories = furnitureTypes
        case "clothing":
            subcategories = sizes
        case "housing":
            subcategories = subletTypes
        case "tickets":
            subcategories = sports
        default:
            subcategories = departments
        }
        print(subcategories.count)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecond" {
            guard let destinationVC = segue.destination as? ShopCollectionViewController, let subcategory = selectedSubcategory else {return}
            destinationVC.category = category
            destinationVC.subcategory = subcategory
        }
    }
}

extension FirstSubcategoryViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return subcategories.count
        } else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath)
            let category = subcategories[indexPath.item]
            cell.backgroundColor = .green
            return cell
        } else {
            let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "classCell", for: indexPath)
            cell.backgroundColor = .blue
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 32)
    }
}
