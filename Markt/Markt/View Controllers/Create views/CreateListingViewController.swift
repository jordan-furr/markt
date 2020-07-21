//
//  CreateListingViewController.swift
//  Markt
//
//  Created by Jordan Furr on 6/27/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class CreateListingViewController: UIViewController {
    
    //MARK: - Properties
    var category: String?
    
    //MARK: - Life Cycle Funcs
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: IB Actions
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
        self.category = "transportation"
        self.performSegue(withIdentifier: "toExtras", sender: self)
    }
    @IBAction func housingTapped(_ sender: Any) {
        self.category = "housing"
        self.performSegue(withIdentifier: "toExtras", sender: self)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let category = category else {return}
        if segue.identifier == "toExtras" {
            let vc = segue.destination as! ExtraSubclassDetailsViewController
            vc.category = category
        }
    }
}
