//
//  CreateListingViewController.swift
//  Markt
//
//  Created by Jordan Furr on 6/27/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class CreateListingViewController: UIViewController {
    
    var category: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func booksTapped(_ sender: Any) {
        self.category = "books"
        self.performSegue(withIdentifier: "toExtras", sender: self)
    }
    @IBAction func furnitureTapped(_ sender: Any) {
        self.category = "furniture"
        self.performSegue(withIdentifier: "toExtras", sender: self)
    }
    @IBAction func electronicsTapped(_ sender: Any) {
        self.category = "electronics"
        self.performSegue(withIdentifier: "toExtras", sender: self)
    }
    @IBAction func ticketsTapped(_ sender: Any) {
        self.category = "tickets"
        self.performSegue(withIdentifier: "toExtras", sender: self)
    }
    @IBAction func clothingTapped(_ sender: Any) {
        self.category = "clothing"
        self.performSegue(withIdentifier: "toExtras", sender: self)
    }
    @IBAction func transportationTapped(_ sender: Any) {
        self.category = "tranportation"
        self.performSegue(withIdentifier: "toExtras", sender: self)
    }
    @IBAction func freeTapped(_ sender: Any) {
        self.category = "free"
        self.performSegue(withIdentifier: "toExtras", sender: self)
    }
    @IBAction func housingTapped(_ sender: Any) {
        self.category = "books"
        self.performSegue(withIdentifier: "toExtras", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let category = category else {return}
        
        if segue.identifier == "toExtras" {
            let vc = segue.destination as! ExtraSubclassDetailsViewController
            vc.category = category
        }
    }
}
