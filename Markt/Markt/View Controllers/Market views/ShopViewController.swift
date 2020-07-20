//
//  ShopViewController.swift
//  Markt
//
//  Created by Jordan Furr on 7/20/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController {

    @IBOutlet weak var subsubCategoryLabel: UILabel!
    @IBOutlet weak var shopCollectionView: UICollectionView!
    
    var listings: [Listing] = []
    var category: String?
    var subcategory: String?
    
    override func viewWillAppear(_ animated: Bool) {
        ListingController.shared.loadAllListings {
            self.collectionView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ShopViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}
