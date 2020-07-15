//
//  Extensions.swift
//  Markt
//
//  Created by Jordan Furr on 7/15/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(urlString: NSString){
        
        //check cache for image
        if let cachedImage = imageCache.object(forKey: urlString){
            self.image = cachedImage
            return
        }
        let url = URL(string: urlString as String)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, responses, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString)
                    self.image = downloadedImage
                }
            }
        }).resume()
    }
}
