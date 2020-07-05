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
            "iconPhotoID" : listing.iconPhotoID as String,
            "uid" : listing.uid as String,
            "category" : listing.category as String
            ] as [String : Any]
        listingRef.document(listing.uid).setData(listingInfoDict)
    }
    
    func createBookListing(with book: Book){
        let listingInfoDict = [
            "title" : book.title as String,
            "subtitle" : book.subtitle as String,
            "price" : book.price as Double,
            "description": book.description as String,
            "ownerUID" : book.ownerUID as String,
            "iconPhotoID" : book.iconPhotoID as String,
            "uid" : book.uid as String,
            "category" : "books",
            "department" : book.department as String,
            "classNumber" : book.classNumber as String
            ] as [String : Any]
        listingRef.document(book.uid).setData(listingInfoDict)
    }
    
    func createTicketListing(with ticket: Ticket){
        let listingInfoDict = [
            "title" : ticket.title as String,
            "subtitle" : ticket.subtitle as String,
            "price" : ticket.price as Double,
            "description": ticket.description as String,
            "ownerUID" : ticket.ownerUID as String,
            "iconPhotoID" : ticket.iconPhotoID as String,
            "uid" : ticket.uid as String,
            "category" : "tickets",
            "opponent" : ticket.opponent as String,
            "date" : ticket.date! as Date
            ] as [String : Any]
        listingRef.document(ticket.uid).setData(listingInfoDict)
    }
    
    func createSubletListing(with sublet: Sublet){
           let listingInfoDict = [
               "title" : sublet.title as String,
               "subtitle" : sublet.subtitle as String,
               "price" : sublet.price as Double,
               "description": sublet.description as String,
               "ownerUID" : sublet.ownerUID as String,
               "iconPhotoID" : sublet.iconPhotoID as String,
               "uid" : sublet.uid as String,
               "category" : "housing",
               "date" : sublet.date! as Date,
               "subletType" : sublet.subletType as String
               ] as [String : Any]
           listingRef.document(sublet.uid).setData(listingInfoDict)
       }
    
    func createClothingListing(with clothingItem: ClothingItem){
        let listingInfoDict = [
            "title" : clothingItem.title as String,
            "subtitle" : clothingItem.subtitle as String,
            "price" : clothingItem.price as Double,
            "description": clothingItem.description as String,
            "ownerUID" : clothingItem.ownerUID as String,
            "iconPhotoID" : clothingItem.iconPhotoID as String,
            "uid" : clothingItem.uid as String,
            "category" : "clothing",
            "size" : clothingItem.size as String
            ] as [String : Any]
        listingRef.document(clothingItem.uid).setData(listingInfoDict)
    }
    
    func createFurnitureListing(with furnitureItem: FurnitureItem){
        let listingInfoDict = [
            "title" : furnitureItem.title as String,
            "subtitle" : furnitureItem.subtitle as String,
            "price" : furnitureItem.price as Double,
            "description": furnitureItem.description as String,
            "ownerUID" : furnitureItem.ownerUID as String,
            "iconPhotoID" : furnitureItem.iconPhotoID as String,
            "uid" : furnitureItem.uid as String,
            "category" : "furniture",
            "type" : furnitureItem.type as String
            ] as [String : Any]
        listingRef.document(furnitureItem.uid).setData(listingInfoDict)
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
    
    func fetchListingsInCategory(category: String, completion: @escaping (Result<[Listing]?, ListingError>) -> Void) {
        var listings: [Listing] = []
        db.collection("listings").whereField("category", isEqualTo: category).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("no listings found", error.localizedDescription)
                return completion(.failure(.noRecordFound))
            } else {
                for document in querySnapshot!.documents {
                    self.fetchListing(listingUID: document.documentID) { (result) in
                        switch result {
                        case .success(let listing):
                            guard let listing = listing else {return}
                            listings.append(listing)
                        case .failure(let error):
                            print(error.errorDescription)
                        }
                    }
                }
            }
        }
        return completion(.success(listings))
    }
    
    func fetchDate(listingUID: String, completion: @escaping (Result<Date?, ListingError>) -> Void) {
        let listingDoc = listingRef.document(listingUID)
               listingDoc.getDocument { (snapshot, error) in
                   if snapshot != nil {
                       guard let snapshot = snapshot else { return completion(.failure(.noListingFound)) }
                    let timestamp: Timestamp = snapshot.get("date") as! Timestamp
                    let date: Date = timestamp.dateValue()
                       return completion(.success(date))
                   } else {
                       print("snapshot is nil")
                       return completion(.failure(.noRecordFound))
                   }
               }
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
    
    func fetchTicket(listingUID: String, completion: @escaping (Result<Ticket?, ListingError>) -> Void) {
           let listingDoc = listingRef.document(listingUID)
           listingDoc.getDocument { (snapshot, error) in
               if snapshot != nil {
                   guard let snapshot = snapshot else { return completion(.failure(.noListingFound)) }
                   guard let data = snapshot.data() else { return completion(.failure(.couldNotUnwrapListing)) }
                   let listing = try! FirestoreDecoder().decode(Ticket.self, from: data)
                   return completion(.success(listing))
               } else {
                   print("snapshot is nil")
                   return completion(.failure(.noRecordFound))
               }
           }
       }
    
    func fetchSublet(listingUID: String, completion: @escaping (Result<Sublet?, ListingError>) -> Void) {
        let listingDoc = listingRef.document(listingUID)
        listingDoc.getDocument { (snapshot, error) in
            if snapshot != nil {
                guard let snapshot = snapshot else { return completion(.failure(.noListingFound)) }
                guard let data = snapshot.data() else { return completion(.failure(.couldNotUnwrapListing)) }
                let listing = try! FirestoreDecoder().decode(Sublet.self, from: data)
                return completion(.success(listing))
            } else {
                print("snapshot is nil")
                return completion(.failure(.noRecordFound))
            }
        }
    }
}
extension Timestamp: TimestampType {}
