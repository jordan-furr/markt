//
//  SubCategoryCollectionViewCell.swift
//  Markt
//
//  Created by Jordan Furr on 7/6/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class SubCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func layoutSubviews() {
           super.layoutSubviews()
           layer.cornerRadius = 10
           backgroundColor = .random()  // very important
           layer.masksToBounds = false
           layer.shadowOpacity = 0.23
           layer.shadowRadius = 2
           layer.shadowOffset = CGSize(width: 0, height: 0)
           layer.shadowColor = UIColor.black.cgColor
       }
    
}
