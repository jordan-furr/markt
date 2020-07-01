//
//  ExtraSubclassDetailsViewController.swift
//  Markt
//
//  Created by Jordan Furr on 6/29/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class ExtraSubclassDetailsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
  
    
    //MARK: PROPERTIES
    var subCategories: [String] = {["N/A"]}()
    var category: String?
    var selectedSubclass: String?
    var createdListing: Listing?
    
    
    //MARK: IB OUTLETS
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var subclassLabel: UITextField!
    @IBOutlet weak var listingInfo1: UITextField!
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createPickerView()
        dismissPickerView()
    }
    
    //MARK: - CREATE LISTING
    @IBAction func createTapped(_ sender: Any) {
        guard let category = category else {return}
        
        let title = titleLabel.text ?? "no title"
        let subClass = subclassLabel.text ?? "N/A"
        let subtitle = subtitleTextField.text ?? "no subtitle"
        let price = Double(priceLabel.text ?? "0") ?? 0
        var description = descriptionTextView.text ?? ""
        if description == "..." || description == "" {
            description = "No description provided :("
        }
        let ownerUID = UserController.shared.currentUser!.uid
        let iconPhotoID = ""
        let date = datePicker.date

        switch (category) {
        case "books":
            guard let department = subclassLabel.text, let classNumber = listingInfo1.text else {return}
            createdListing = Book(title: title, subtitle: subtitle, price: price, description: description, ownerUID: ownerUID, iconPhotoID: iconPhotoID, department: department, classNumber: classNumber)
            ListingController.shared.createBookListing(with: createdListing! as! Book)
        case "tickets":
            guard let sport = subclassLabel.text else {return}
            let opponentName = title
            createdListing = Ticket(sport: sport, gameDate: date, price: price, description: description, ownerUID: ownerUID, iconPhotoID: iconPhotoID, opponent: opponentName)
            ListingController.shared.createTicketListing(with: createdListing! as! Ticket)
        case "housing":
            createdListing = Sublet(title: title, subtitle: subtitle, subletType: subClass, price: price, description: description, ownerUID: ownerUID, iconPhotoID: iconPhotoID, dateAvailable: date)
            ListingController.shared.createSubletListing(with: createdListing! as! Sublet)
        case "clothing":
            createdListing = ClothingItem(title: title, subtitle: subtitle, price: price, description: description, ownerUID: ownerUID, iconPhotoID: iconPhotoID, size: subClass)
            ListingController.shared.createClothingListing(with: createdListing! as! ClothingItem)
        case "furniture":
            createdListing = FurnitureItem(title: title, subtitle: subtitle, price: price, description: description, ownerUID: ownerUID, iconPhotoID: iconPhotoID, type: subClass)
            ListingController.shared.createFurnitureListing(with: createdListing! as! FurnitureItem)
        default:
           createdListing = Listing(title: title, subtitle: subtitle, price: 0, description: description, ownerUID: ownerUID, iconPhotoID: iconPhotoID, category: category)
           ListingController.shared.createListing(with: createdListing!)
          
        }
         UserController.shared.addCreatedListing(listingID: createdListing!.uid)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        subclassLabel.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        subclassLabel.inputAccessoryView = toolBar
    }
    
    @objc func action() {
       view.endEditing(true)
    }
    
      func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
      }
      
      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          subCategories.count
      }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return subCategories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSubclass = subCategories[row]
        subclassLabel.text = selectedSubclass
    }
    func setUpViews(){
        dateLabel.isHidden = true
        datePicker.isHidden = true
        descriptionTextView.text = "..."
        titleLabel.placeholder = "Enter Title"
        priceLabel.placeholder = "Asking price"
        guard let category = category else {return}
        switch (category) {
        case "books":
            categoryLabel.text = "New Book"
            subCategories = departments
            listingInfo1.placeholder = "Enter course number"
            subclassLabel.placeholder = "Select Department"
            descriptionTextView.text = "Enter any comments about state of book"
        case "furniture":
            categoryLabel.text = "New Furniture Item"
            subCategories = furnitureTypes
            subclassLabel.placeholder = "Select Type"
            listingInfo1.isHidden = true
        case "electronics":
            categoryLabel.text = "New Electronic Item"
            listingInfo1.isHidden = true
            subclassLabel.isHidden = true
        case "tickets":
            subCategories = sports
            dateLabel.isHidden = false
            datePicker.isHidden = false
            dateLabel.text = "Date of Game:"
            categoryLabel.text = "New Ticket Listing"
            listingInfo1.isHidden = true
            subclassLabel.placeholder = "Select Sport"
            descriptionTextView.text = "Enter info on section/row/seat"
            titleLabel.placeholder = "Enter Opposing Team"
            subtitleTextField.isHidden = true
        case "clothing":
            categoryLabel.text = "New Clothing Item"
            subCategories = sizes
            listingInfo1.isHidden = true
            subclassLabel.placeholder = "Select Size"
        case "transportation":
            categoryLabel.text = "New Tranportation Listing"
            listingInfo1.isHidden = true
            subclassLabel.isHidden = true
        case "housing":
            dateLabel.isHidden = false
            datePicker.isHidden = false
            dateLabel.text = "Date Available:"
            categoryLabel.text = "New Sublet Listing"
            listingInfo1.isHidden = true
            subCategories = subletTypes
            subclassLabel.placeholder = "Select Sublet Type"
            descriptionTextView.text = "Enter a description about this listing."
        default:
            categoryLabel.text = "New Free Item"
            subclassLabel.isHidden = true
            listingInfo1.isHidden = true
            priceLabel.isHidden = true
        }
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
}
