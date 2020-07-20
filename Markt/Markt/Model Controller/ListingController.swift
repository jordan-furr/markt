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
    static let subcategoryKey = "subcategory"
    static let subsubcategoryKey = "subsubCategory"
    static let priceKey = "price"
    static let descriptionKey = "description"
    static let ownerUIDKey = "ownerUID"
    static let iconPhotoIDKey = "iconPhotoID"
    static let categoryKey = "category"
    static let tourImageURLKey = "imageURLS"
}

class ListingController {
    
    static let shared = ListingController()
    let db = Firestore.firestore()
    let storage = Storage.storage()
    lazy var storageRef = storage.reference()
    let listingRef : CollectionReference = Firestore.firestore().collection("listings")
    
    var currentUserLiveListings: [Listing] = []
    var currentCategoryLIstings: [Listing] = []
    var allListings: [Listing] = []
    var imageURLSForNewListing: [String] = []
    
    
    func createListing(with listing: Listing){
        let listingInfoDict = [
            "title" : listing.title as String,
            "subcategory" : listing.subcategory as String,
            "subsubCategory" : listing.subsubCategory as String,
            "price" : listing.price as Double,
            "description": listing.description as String,
            "ownerUID" : listing.ownerUID as String,
            "uid" : listing.uid as String,
            "category" : listing.category as String,
            "date" : listing.date as Date
            ] as [String : Any]
        listingRef.document(listing.uid).setData(listingInfoDict)
    }
    
    func saveImageURLS(listing: Listing) {
        let listingDoc = listingRef.document(listing.uid)
        let data = [
            "\(ListingKeys.tourImageURLKey)" : imageURLSForNewListing as [String]
        ] as [String: Any]
        listingDoc.setData(data, merge: true) { (error) in
            if let error = error {
                 print(error)
            }
        }
    }
    
    func updateListingInfo(listing: Listing, completion: @escaping (Result<Listing?, ListingError>) -> Void) {
        let listingDoc = listingRef.document(listing.uid)
        let data = [
            "\(ListingKeys.titleKey)" : listing.title as String,
            "\(ListingKeys.subcategoryKey)" : listing.subcategory as String,
            "\(ListingKeys.subsubcategoryKey)" : listing.subsubCategory as String,
            "\(ListingKeys.priceKey)" : listing.price as Double,
            "\(ListingKeys.descriptionKey)" : listing.description as String,
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
    
    func fetchClassesForDepartment(department: String, completion: @escaping (Result<[String]?, ListingError>) -> Void) {
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
                    guard let listing = listing else {return completion(.failure(.noListingFound))}
                    self.currentUserLiveListings.append(listing)
                }
            }
        }
        return completion(.success(currentUserLiveListings))
    }
    
    func fetchListingsInCategory(category: String) -> ([Listing]) {
        var listings: [Listing] = []
        for listing in allListings {
            if listing.category == category {
                listings.append(listing)
            }
        }
        return listings
    }
    
    func loadListings(completed: @escaping () -> ()){
    }
    
    func fetchAllListings(completion: @escaping (Result<[Listing]?, ListingError>) -> Void) {
        var listings: [Listing] = []
        db.collection("listings").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("no listings found", error.localizedDescription)
                return completion(.failure(.noRecordFound))
            } else {
                for document in querySnapshot!.documents {
                    self.fetchListing(listingUID: document.documentID) { (result) in
                        switch result {
                        case .success(let listing1):
                            print("success fetching listing")
                            print(listing1?.title)
                            guard let listing2 = listing1 else {return}
                            listings.append(listing2)
                        case .failure(let error):
                            print("failure fetching listing in all listings")
                            print(error.errorDescription)
                        }
                    }
                }
            }
        }
        print("fetch \(listings.count) total listings!!!!")
        allListings = listings
        return completion(.success(allListings))
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
        print(listingUID)
        listingDoc.getDocument { (snapshot, error) in
            if snapshot != nil {
                guard let snapshot = snapshot else { return completion(.failure(.noListingFound)) }
                guard let data = snapshot.data() else { return completion(.failure(.noRecordFound))}
                let listing = try! FirestoreDecoder().decode(Listing.self, from: data)
                for imageURL in listing.imageURLS {
                    listing.loadImageUsingCacheWithURLString(urlString: imageURL as NSString)
                }
                return completion(.success(listing))
            } else {
                print("snapshot is nil")
                return completion(.failure(.noRecordFound))
            }
        }
    }
    
    func uploadPhoto(image: Data?, listingUID: String, completion: @escaping (Result<String?, ImageError>) -> Void)  {
        guard let data = image, let uid = UserController.shared.currentUser?.uid else { print("Image Failed to upload"); return }
        let imageName = UUID().uuidString
        let imageReference = Storage.storage().reference().child("\(uid)/\(listingUID)").child(imageName)
        imageReference.putData(data, metadata: nil) { (metaData, error) in
            if error != nil {
                print("Error uploading Image")
                completion(.failure(.couldNotUploadImage))
            }
            imageReference.downloadURL(completion: { (url, error) in
                if error != nil {
                    print("Error uploading Image")
                }
                guard let url = url else { return }
                completion(.success(url.absoluteString))
            })
        }
    }
    
    func downloadPhoto(urlPath: String, completion: @escaping (Result<UIImage?, ImageError>) -> Void) {
        let locationImageReference = storageRef.child(urlPath)
        locationImageReference.getData(maxSize: 10000000) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let picture = UIImage(data: data!) else { return completion(.failure(.noImageFound))}
                completion(.success(picture) )
            }
            completion(.failure(.couldNotUnwrapImage))
        }
    }
}


extension Timestamp: TimestampType {}
