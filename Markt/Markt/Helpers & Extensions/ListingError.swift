//
//  ListingError.swift
//  Markt
//
//  Created by Jordan Furr on 6/28/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation

enum ListingError: LocalizedError {
    case firebaseError(Error)
    case noListingFound
    case couldNotUnwrapListing
    case noRecordFound
    case noUserLoggedIn
    case noUserForRecord
    
    var errorDescription: String {
        switch self {
        case .firebaseError(let error):
            return ("Firebase returned an error: \(error.localizedDescription)")
        case .noListingFound:
            return "No listing was found"
        case .couldNotUnwrapListing:
            return "Could not unwrap the listing."
        case .noRecordFound:
            return "No user record was found."
        case .noUserLoggedIn:
            return "No user logged in, please visit settings and check your user status"
        case .noUserForRecord:
            return "No user for this record can be found."
        }
    }
}
