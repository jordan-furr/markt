//
//  ExtraSubclassDetailsViewController.swift
//  Markt
//
//  Created by Jordan Furr on 6/29/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

//SHIPS CREATED LISTING
class ExtraSubclassDetailsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    //MARK: PROPERTIES
    var subCategories: [String] = {["N/A"]}()
    var category: String?
    var selectedSubclass: String?
    var createdListing: Listing?
    var images: [UIImage] = []
    
    //MARK: - IB OUTLETS
    @IBOutlet weak var categoryLabel: UILabel! ; @IBOutlet weak var subclassLabel: UITextField!
    @IBOutlet weak var listingInfo1: UITextField! ; @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var priceLabel: UITextField! ; @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var createButton: UIButton! ; @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker! ; @IBOutlet weak var collectionOfImagesToUse: UICollectionView!
    @IBOutlet weak var addpicsButton: UIButton!
    
    //MARK: - Life Cycle Funcs
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - IB ACTIONS
    
    //MARK: - CREATE LISTING
    @IBAction func createTapped(_ sender: Any) {
        guard let category = category, let user = UserController.shared.currentUser else {return}
        
        let title = titleLabel.text ?? "no title" ; let subClass = subclassLabel.text ?? "N/A" ; let price = Double(priceLabel.text ?? "0") ?? 0 ; var description = descriptionTextView.text ?? "" ; let date = datePicker.date
        if description == "" { description = "No description provided :(" }
        
        switch (category) {
        case "books":
            let classNumber = listingInfo1.text!
            createdListing = Listing(title: title, subcategory: subClass, subsubCategory: classNumber, price: price, description: description, ownerUID: user.uid, category: category)
        case "tickets":
            createdListing = Listing(title: (title + " " + subClass), subcategory: subClass, subsubCategory: title, price: price, description: description, ownerUID: user.uid, category: category)
            createdListing?.date = date
        case "housing":
            createdListing = Listing(title: title, subcategory: subClass, subsubCategory: String(user.campusLocation), price: price, description: description, ownerUID: user.uid, category: category)
            createdListing?.date = date
        case "clothing":
            //FIXME::::: ADD CLOTHING ITEM TYPE
            createdListing = Listing(title: title, subcategory: "" , subsubCategory: subClass, price: price, description: description, ownerUID: user.uid, category: category)
        case "furniture":
            createdListing = Listing(title: title, subcategory: subClass, subsubCategory: "", price: price, description: description, ownerUID: user.uid, category: category)
        default:
            createdListing = Listing(title: title, subcategory: "", subsubCategory: "", price: price, description: description, ownerUID: user.uid, category: category)
            break;
        }
        
        ListingController.shared.createListing(with: createdListing!)
        ListingController.shared.uploadListingImages(listing: createdListing!, images: images)
        UserController.shared.addCreatedListing(listingID: createdListing!.uid)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImageTapped(_ sender: Any) {
        showChooseSourceTypeAlertController()
        collectionOfImagesToUse.reloadData()
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    //MARK: - Helpers
    @objc func action() {
        view.endEditing(true)
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
    
    //MARK: - Picker View funcs
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
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
}

extension ExtraSubclassDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "imagePreview", for: indexPath) as? ImageCollectionViewCell else {return UICollectionViewCell()}
        cell.imageView.image = images[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 85, height: 85)
    }
}

extension ExtraSubclassDetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showChooseSourceTypeAlertController() {
        let photoLibraryAction = UIAlertAction(title: "Choose a Photo", style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Take a New Photo", style: .default) { (action) in
            self.showImagePickerController(sourceType: .camera)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        AlertService.showAlert(style: .actionSheet, title: nil, message: nil, actions: [photoLibraryAction, cameraAction, cancelAction], completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            images.append(editedImage.withRenderingMode(.alwaysOriginal))
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            images.append(originalImage.withRenderingMode(.alwaysOriginal))
        }
        collectionOfImagesToUse.isHidden = false
        collectionOfImagesToUse.reloadData()
        dismiss(animated: true, completion: nil)
    }
}
