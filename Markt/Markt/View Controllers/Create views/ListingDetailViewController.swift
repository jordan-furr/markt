//
//  ListingDetailViewController.swift
//  Markt
//
//  Created by Jordan Furr on 6/28/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import CodableFirebase
import UIKit

class ListingDetailViewController: UIViewController {

    //MARK: - IB OUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dropOffLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceView: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var submitView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    
    var listing: Listing?
    
    override func viewWillAppear(_ animated: Bool) {
        setUpViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    func setUpViews(){
        guard let listing = listing, let user = UserController.shared.currentUser else {return}
        dateLabel.isHidden = true
        if listing.ownerUID == user.uid {
           heartButton.isHidden = true
            submitView.isHidden = true
            moreButton.isHidden = true
        }
        if listing.category == "tickets" || listing.category == "housing" {
            dateLabel.isHidden = false
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
                ListingController.shared.fetchDate(listingUID: listing.uid, completion: { (result) in
                switch result {
                    case .success(let date):
                        guard let date = date else {return}
                        let dateString = df.string(from: date)
                        if listing.category == "housing" {
                            self.dateLabel.text = "Available: " + dateString
                        } else {
                             self.dateLabel.text = "Game Date: " + dateString
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            })
        }
        descriptionTextView.isEditable = false
        descriptionTextView.isSelectable = false
        descriptionTextView.text = listing.description
        titleLabel.text = listing.title
        subtitleLabel.text = listing.subcategory
        priceView.text = "\(listing.price)$"
        locationLabel.addLocationColoringAndText(user: user)
        locationLabel.layer.cornerRadius = 8
        dropOffLabel.layer.cornerRadius = 8
        dropOffLabel.addDropOffColoringAndText(user: user)
        let image = UIImage(named: listing.category)
        imageView.image = image
    }
    
    
    @IBAction func submitTapped(_ sender: Any) {
        messageTextField.text = ""
    }
    
    @IBAction func heartTapped(_ sender: Any) {
        print("tapepd heart")
        guard let listing = listing else {return}
        
        if heartButton.backgroundColor == .red {
            heartButton.backgroundColor = .white
            UserController.shared.unSaveListing(listingID: listing.uid)
        } else {
            heartButton.backgroundColor = .red
            UserController.shared.saveListing(listingID: listing.uid)
        }
    }
    
}

