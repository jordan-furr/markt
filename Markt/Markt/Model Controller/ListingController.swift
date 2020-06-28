//
//  ListingController.swift
//  Markt
//
//  Created by Jordan Furr on 6/24/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import CodableFirebase
import FirebaseAuth

struct ListingKeys {
    static let uidKey = "uid"
    static let titleKey = "title"
    static let subtitleKey = "subtitle"
    static let priceKey = "price"
    static let descriptionKey = "description"
    static let ownerUIDKey = "ownerUID"
    static let iconPhotoIDKey = "iconPhotoID"
    static let willingToDeliverKey = "willingToDeliver"
}

class ListingController {
    
    static let shared = ListingController()
    let db = Firestore.firestore()
    let storage = Storage.storage()
    lazy var storageRef = storage.reference()
    let listingRef : CollectionReference = Firestore.firestore().collection("listings")
    
    
    func createListing(with listing: Listing){
        let listingInfoDict = [
            "title" : listing.title as String,
            "subtitle" : listing.subtitle as String,
            "price" : listing.price as Double,
            "description": listing.description as String,
            "ownerUID" : listing.ownerUID as String,
            "iconPhotoID" : "",
            "uid" : listing.uid as String
        ] as [String : Any]
        listingRef.document(listing.uid).setData(listingInfoDict)
    }
    
    
    func fetchListing(listingUID: String, completion: @escaping (Result<Listing?, ListingError>) -> Void) {
       
        let listingDoc = listingRef.document(listingUID)
        listingDoc.getDocument { (snapshot, error) in
            if snapshot != nil {
                guard let snapshot = snapshot else { return completion(.failure(.noListingFound)) }
                guard let data = snapshot.data() else { return completion(.failure(.couldNotUnwrapListing)) }
                let listing = try! FirestoreDecoder().decode(Listing.self, from: data)
                return completion(.success(listing))
            } else {
                print("snapshot is nil")
                return completion(.failure(.noRecordFound))
            }
        }
    }
}
