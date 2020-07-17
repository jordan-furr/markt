//
//  ClassCollectionViewCell.swift
//  Markt
//
//  Created by Jordan Furr on 7/6/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class ClassCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var classLabel: UILabel!
    
    override func layoutSubviews() {
           super.layoutSubviews()
           layer.cornerRadius = 12
           let opaqueColor: UIColor = UIColor.random().withAlphaComponent(0.69)
           backgroundColor = opaqueColor// very important // very important
           layer.masksToBounds = false
           layer.shadowOpacity = 0.23
           layer.shadowRadius = 4
           layer.shadowOffset = CGSize(width: 0, height: 0)
           layer.shadowColor = UIColor.black.cgColor
       }
}
