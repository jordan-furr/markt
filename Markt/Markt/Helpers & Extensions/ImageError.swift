//
//  ImageError.swift
//  Markt
//
//  Created by Jordan Furr on 6/24/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation

enum ImageError: LocalizedError {
    
    case noImageFound
    case couldNotUnwrapImage
    case couldNotUploadImage

    var errorDescription: String? {
        switch self {
        case .noImageFound:
            return "No image found."
        case .couldNotUnwrapImage:
            return "Could not unwrap image."
        case .couldNotUploadImage:
            return "Image could not be uploaded"
        }
    }
}
