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
    
    
    //MARK: IB OUTLETS
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var subclassLabel: UITextField!
    @IBOutlet weak var listingInfo1: UITextField!
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpViews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        createPickerView()
        dismissPickerView()
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
        descriptionTextView.text = "Enter a short description about this item"
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
            subclassLabel.placeholder = "Select Type"
        case "tickets":
            categoryLabel.text = "New Ticket Listing"
            listingInfo1.placeholder = "Enter Game Date"
            subclassLabel.placeholder = "Select Opponent"
            descriptionTextView.text = "Enter info on section/row/seat"
            titleLabel.isHidden = true
        case "clothing":
            categoryLabel.text = "New Clothing Item"
            subCategories = sizes
            listingInfo1.isHidden = true
            subclassLabel.placeholder = "Select Size"
        case "transportation":
            categoryLabel.text = "New Tranportation Listing"
            listingInfo1.isHidden = true
        case "housing":
            categoryLabel.text = "New Sublet Listing"
            listingInfo1.placeholder = "When is this sublet available?"
            subclassLabel.placeholder = "Select Sublet Type"
            descriptionTextView.text = "Enter a description about this listing."
        default:
            categoryLabel.text = "New Free Item"
            subclassLabel.isHidden = true
            listingInfo1.isHidden = true
        }
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
}
