//
//  ExtraSubclassVC+Extensions.swift
//  Markt
//
//  Created by Jordan Furr on 7/17/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation

extension ExtraSubclassDetailsViewController {
    
    //MARK: - Setting up views
    func setUpViews(){
        guard let category = category else {return}
        setDelegatesAndVisibilityEtc()
        
        switch (category) {
        case "books":
            categoryLabel.text = "New Book"
            subCategories = departments
            listingInfo1.isHidden = false
            listingInfo1.placeholder = "Enter course number"
            subclassLabel.text = subCategories[0]
        case "furniture":
            categoryLabel.text = "New Furniture Item"
            subCategories = furnitureTypes
            subclassLabel.text = subCategories[0]
        case "electronics":
            categoryLabel.text = "New Electronic Item"
            subCategories = electronicTypes
            subclassLabel.text = subCategories[0]
        case "tickets":
            collectionOfImagesToUse.isHidden = true
            addpicsButton.isHidden = true
            subCategories = sports
            dateLabel.isHidden = false
            datePicker.isHidden = false
            dateLabel.text = "Date of Game:"
            categoryLabel.text = "New Ticket Listing"
            subclassLabel.text = subCategories[0]
            descriptionTextView.text = "Enter info on section/row/seat"
            titleLabel.placeholder = "Enter Opposing Team"
        case "clothing":
            categoryLabel.text = "New Clothing Item"
            subCategories = clothingTypes
            subclassLabel.text = subCategories[0]
        case "transportation":
            categoryLabel.text = "New Tranportation Listing"
            subCategories = transportTypes
            subclassLabel.text = subCategories[0]
        case "housing":
            dateLabel.isHidden = false
            datePicker.isHidden = false
            dateLabel.text = "Date Available:"
            categoryLabel.text = "New Sublet Listing"
            subCategories = subletTypes
            subclassLabel.text = subCategories[0]
            descriptionTextView.text = "Enter a description about this listing."
        default:
            categoryLabel.text = "New Free Item"
            subCategories = freeCategories
            subclassLabel.text = subCategories[0]
            priceLabel.isHidden = true
        }
    }
    
    func setDelegatesAndVisibilityEtc(){
        if images.count == 0 {
            collectionOfImagesToUse.isHidden = true
        }
        listingInfo1.isHidden = true
        createPickerView()
        dismissPickerView()
        createButton.addCornerRadius()
        addpicsButton.addCornerRadius()
        collectionOfImagesToUse.delegate = self
        collectionOfImagesToUse.dataSource = self
        dateLabel.isHidden = true
        datePicker.isHidden = true
        descriptionTextView.text = ""
        titleLabel.placeholder = "Enter Title"
        priceLabel.placeholder = "Asking price"
    }
}


