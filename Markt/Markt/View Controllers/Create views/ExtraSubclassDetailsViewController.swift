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
    var numImages = 0
    var images: [UIImage] = []
    
    
    //MARK: IB OUTLETS
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var subclassLabel: UITextField!
    @IBOutlet weak var listingInfo1: UITextField!
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var priceLabel: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var collectionOfImagesToUse: UICollectionView!
    @IBOutlet weak var addpicsButton: UIButton!
    

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
        guard let classNumber = listingInfo1.text else {return}
        let title = titleLabel.text ?? "no title"
        let subClass = subclassLabel.text ?? "N/A"
        let price = Double(priceLabel.text ?? "0") ?? 0
        var description = descriptionTextView.text ?? ""
        if description == "..." || description == "" {
            description = "No description provided :("
        }
        let user = UserController.shared.currentUser!
        let iconPhotoID = ""
        let date = datePicker.date

        
        switch (category) {
        case "books":
            createdListing = Listing(title: title, subcategory: subClass, subsubCategory: classNumber, price: price, description: description, ownerUID: user.uid, iconPhotoID: iconPhotoID, category: category)
        case "tickets":
            createdListing = Listing(title: "", subcategory: subClass, subsubCategory: title, price: price, description: description, ownerUID: user.uid, iconPhotoID: iconPhotoID, category: category)
            createdListing?.date = date
        case "housing":
            createdListing = Listing(title: title, subcategory: subClass, subsubCategory: String(user.campusLocation), price: price, description: description, ownerUID: user.uid, iconPhotoID: iconPhotoID, category: category)
            createdListing?.date = date
        case "clothing":
            //FIXME::::: ADD CLOTHING ITEM TYPE
            createdListing = Listing(title: title, subcategory: "" , subsubCategory: subClass, price: price, description: description, ownerUID: user.uid, iconPhotoID: iconPhotoID, category: category)
        case "furniture":
            createdListing = Listing(title: title, subcategory: subClass, subsubCategory: "", price: price, description: description, ownerUID: user.uid, iconPhotoID: iconPhotoID, category: category)
        default:
            createdListing = Listing(title: title, subcategory: "", subsubCategory: "", price: price, description: description, ownerUID: user.uid, iconPhotoID: iconPhotoID, category: category)
            break;
        }
        
        ListingController.shared.createListing(with: createdListing!)
        
         UserController.shared.addCreatedListing(listingID: createdListing!.uid)
        self.dismiss(animated: true, completion: nil)
        ListingController.shared.fetchCurrentUsersListings { (result) in
            switch result {
            case .failure(let error):
                print("Could not fetch user's live listings")
                print(error, error.localizedDescription)
            case .success(let listings):
                print("live user listings fetched"); if (listings != nil) { print(listings!)}
            }
        }
    }
    
    
    
    @IBAction func addImageTapped(_ sender: Any) {
        showChooseSourceTypeAlertController()
        numImages = numImages + 1
        collectionOfImagesToUse.reloadData()
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
        if images.count == 0 {
            collectionOfImagesToUse.isHidden = true
        }
        createButton.addCornerRadius()
        addpicsButton.addCornerRadius()
        collectionOfImagesToUse.delegate = self
        collectionOfImagesToUse.dataSource = self
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
            subclassLabel.text = subCategories[0]
        case "furniture":
            categoryLabel.text = "New Furniture Item"
            subCategories = furnitureTypes
            subclassLabel.text = subCategories[0]
            listingInfo1.isHidden = true
        case "electronics":
            categoryLabel.text = "New Electronic Item"
            listingInfo1.isHidden = true
            subclassLabel.isHidden = true
        case "tickets":
            collectionOfImagesToUse.isHidden = true
            addpicsButton.isHidden = true
            subCategories = sports
            dateLabel.isHidden = false
            datePicker.isHidden = false
            dateLabel.text = "Date of Game:"
            categoryLabel.text = "New Ticket Listing"
            listingInfo1.isHidden = true
            subclassLabel.text = subCategories[0]
            descriptionTextView.text = "Enter info on section/row/seat"
            titleLabel.placeholder = "Enter Opposing Team"
        case "clothing":
            categoryLabel.text = "New Clothing Item"
            subCategories = sizes
            listingInfo1.isHidden = true
            subclassLabel.text = subCategories[0]
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
            subclassLabel.text = subCategories[0]
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
    
/*
 switch (category) {
      case "books":
          break;
      case "tickets":
          break;
      case "housing":
          break;
      case "clothing":
          break
      case "furniture":
          break;
      default:
          break;
      }
 */
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


