//
//  ExtraSubclassDetailsViewController.swift
//  Markt
//
//  Created by Jordan Furr on 6/29/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class ExtraSubclassDetailsViewController: UIViewController {
    
    var category: String?
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUpViews(){
        guard let category = category else {return}
        switch (category) {
        case "books":
            categoryLabel.text = "New Book"
        case "furniture":
            categoryLabel.text = "New furniture item"
        case "electronics":
            categoryLabel.text = "New electronic item"
        case "tickets":
            categoryLabel.text = "New ticket listing"
        case "clothing":
            categoryLabel.text = "New clothing item"
        case "transportation":
            categoryLabel.text = "New tranportation listing"
        case "housing":
            categoryLabel.text = "New sublet listing"
        default:
            categoryLabel.text = "New Free Item"
        }
    }
}
