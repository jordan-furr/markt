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
    @IBOutlet weak var titleLabel: UILabel! ; @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel! ; @IBOutlet weak var dropOffLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView! ; @IBOutlet weak var priceView: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView! ; @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton! ; @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var submitView: UIView! ; @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    //MARK: - Properties
    var listing: Listing?
    
    //MARK: - Life Cycle Functions
    override func viewWillAppear(_ animated: Bool) {
        setUpViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: IB ACTIONS
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
    
    //MARK: - HELPERS
    func setUpViews(){
        guard let listing = listing, let user = UserController.shared.currentUser else {return}
        if listing.ownerUID == user.uid {setUpForListingOwnedByUser()}
        
        setInteractionUISpecifics(listing, user)
        imageView.loadImageUsingCacheWithUrlString(urlString: listing.imageURLS.first! as NSString)

        switch listing.category {
        case "books":
            subtitleLabel.text = listing.subcategory + " " + listing.subsubCategory
        case "tickets":
            dateLabel.isHidden = false
            setDateLabelWithListingID(listing: listing)
            titleLabel.text = listing.subsubCategory + " " + listing.subcategory
        case "housing":
            dateLabel.isHidden = false
            setDateLabelWithListingID(listing: listing)
        case "clothing":
            subtitleLabel.text = listing.subcategory + " " + listing.subsubCategory
        default:
            break
        }
    }
    
    func setInteractionUISpecifics(_ listing: Listing, _ user: User){
        dateLabel.isHidden = true
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
    }
    func setUpForListingOwnedByUser(){
        heartButton.isHidden = true
        submitView.isHidden = true
        moreButton.isHidden = true
    }
}

