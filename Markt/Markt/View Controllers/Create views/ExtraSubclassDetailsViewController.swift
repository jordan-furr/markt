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
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        listingInfo1.placeholder = "xxx"
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
          departments.count
      }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return departments[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSubclass = departments[row]
        subclassLabel.text = selectedSubclass
    }
    func setUpViews(){
        guard let category = category else {return}
        switch (category) {
        case "books":
            categoryLabel.text = "New Book"
            subCategories = departments
        case "furniture":
            categoryLabel.text = "New furniture item"
            subCategories = furnitureTypes
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
    
    @IBAction func backgroundTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
}
