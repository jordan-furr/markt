//
//  CategoryCollectionViewCell.swift
//  Markt
//
//  Created by Jordan Furr on 7/2/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit
//
//protocol CategoryCollectionViewCellDelegate: class {
//    func selectedCategory(category: String)
//}

class CategoryCollectionViewCell: UICollectionViewCell {
    
  //  var delegate: CategoryCollectionViewCellDelegate?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    var category: String?
    
    func setCategory(category: String){
        self.category = category
        updateUI()
    }
    
    func updateUI(){
        guard let category = category else {return}
        imageView.image = UIImage(named: category)
        categoryTitle.text = category
        if category == "transportation" {
            categoryTitle.text = "transport"
        }
    }
}
