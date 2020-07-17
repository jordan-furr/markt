//
//  ImageCollectionViewCell.swift
//  Markt
//
//  Created by Jordan Furr on 7/12/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
    }
}
