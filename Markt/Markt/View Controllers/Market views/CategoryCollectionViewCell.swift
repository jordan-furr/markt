//
//  CategoryCollectionViewCell.swift
//  Markt
//
//  Created by Jordan Furr on 7/2/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var category: String?
    
    func setCategory(category: String){
        self.category = category
        updateUI()
    }
    
    func updateUI(){
        guard let category = category else {return}
        imageView.image = UIImage(named: category)
    }
}
