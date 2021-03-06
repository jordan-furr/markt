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
    
    var category: String?
    
    func setCategory(category: String){
        self.category = category
        updateUI()
    }
    
    func updateUI(){
        guard let category = category else {return}
        self.contentView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: category)
    }
    override func layoutSubviews() {
           super.layoutSubviews()
           layer.cornerRadius = 10
           backgroundColor = .white // very important
           layer.masksToBounds = false
           layer.shadowOpacity = 0.23
        layer.shadowRadius = 2.5
           layer.shadowOffset = CGSize(width: 0, height: 0)
           layer.shadowColor = UIColor.black.cgColor
       }
}
