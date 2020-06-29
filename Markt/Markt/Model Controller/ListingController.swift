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
    static let categoryKey = "category"
}

class ListingController {
    
    static let shared = ListingController()
    let db = Firestore.firestore()
    let storage = Storage.storage()
    lazy var storageRef = storage.reference()
    let listingRef : CollectionReference = Firestore.firestore().collection("listings")
    
    var currentUserLiveListings: [Listing] = []
    
    
    func createListing(with listing: Listing){
        let listingInfoDict = [
            "title" : listing.title as String,
            "subtitle" : listing.subtitle as String,
            "price" : listing.price as Double,
            "description": listing.description as String,
            "ownerUID" : listing.ownerUID as String,
            "iconPhotoID" : "",
            "uid" : listing.uid as String,
            "category" : listing.category as String
            ] as [String : Any]
        listingRef.document(listing.uid).setData(listingInfoDict)
    }
    
    func updateListingInfo(listing: Listing, completion: @escaping (Result<Listing?, ListingError>) -> Void) {
        let listingDoc = listingRef.document(listing.uid)
        let data = [
            "\(ListingKeys.titleKey)" : listing.title as String,
            "\(ListingKeys.subtitleKey)" : listing.subtitle as String,
            "\(ListingKeys.priceKey)" : listing.price as Double,
            "\(ListingKeys.descriptionKey)" : listing.description as String,
            "\(ListingKeys.iconPhotoIDKey)" : listing.iconPhotoID as String,
            "\(ListingKeys.categoryKey)" : listing.category as  String
            ] as [String : Any]
        listingDoc.setData(data, merge: true) { (error) in
            if let error = error {
                return completion(.failure(.firebaseError(error)))
            } else {
                guard let user = UserController.shared.currentUser else {return  completion(.failure(.noUserLoggedIn))}
                guard let index = user.myListings.firstIndex(of: listing.uid) else {return completion(.failure(.noRecordFound))}
                var listings = ListingController.shared.currentUserLiveListings
                listings[index] = listing
                ListingController.shared.currentUserLiveListings = listings
                return completion(.success(listing))
            }
        }
    }
    
    func deleteListing(listing: Listing, completion: @escaping (Result<Listing?, ListingError>) -> Void) {
        guard let user = UserController.shared.currentUser else {return  completion(.failure(.noUserLoggedIn))}
        guard let index = user.myListings.firstIndex(of: listing.uid) else {return completion(.failure(.noRecordFound))}
        var listings = ListingController.shared.currentUserLiveListings
        listings.remove(at: index)
        ListingController.shared.currentUserLiveListings = listings
        UserController.shared.deleteListing(listingID: listing.uid)
    }
    
    func fetchClassesForDepartment(department: String, completion: @escaping (Result<[Int]?, ListingError>) -> Void) {
       // let classNumbers: [Int] = []
       // bookRef.
    }
    
    func fetchCurrentUsersListings(completion: @escaping (Result<[Listing]?, ListingError>) -> Void) {
        guard let user = UserController.shared.currentUser else {return completion(.failure(.noUserLoggedIn))}
        currentUserLiveListings = []
        for listingID in user.myListings {
            fetchListing(listingUID: listingID) { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let listing):
                    guard let listing = listing else {return completion(.failure(.couldNotUnwrapListing))}
                    self.currentUserLiveListings.append(listing)
                }
            }
        }
        return completion(.success(currentUserLiveListings))
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
