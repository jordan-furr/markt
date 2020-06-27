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
    
    
    func createListing(with title: String, subtitle: String, price: Double, description: String, ownerUID: String, iconPhotoID: String, willingToDeliver: Bool){
    }
    
    /*
     func createTour(tour: Tour) {
           let tourUID = LocationController.shared.fetchObjectUID(location: nil, tour: tour)
           let tourImages = TourController.shared.tourImagesSomeImage
       
           for image in tourImages {
               
               LocationController.shared.uploadPhoto(image: image, objectUID: tourUID) { (result) in
                   switch result {
                   case .none:
                       print("There was a problem uploading Image")
                   case .some(let imageURL):
                       self.tourImageURLs.append(imageURL)
                   }
               }
               
               let tourInfoDictionary = [
                   
                   "title" : (tour.title ?? "Tour Title") as String,
                   "imageURLs" : tourImageURLs as [String],
                   "tourImages" : tour.imageURLs,
                   //"rating" : tour.rating,
                   "type" : tour.type as Any,
                   "length" : tour.length as Any,
                   "walkingTime" : tour.walkingTime as Any,
                   "tourCreator" : tour.tourCreator,
                   "tourUID" : tour.tourUID,
                   "locations" : tour.locations,
                   "description" : tour.description,
                   "aboutGuide" : tour.aboutGuide,
                   //"otherToursCreatedByGuide" : tour.otherToursCreatedByGuide
                   
                   ] as [String : Any]
               
               db.collection("tours").document(tourUID).setData(tourInfoDictionary)
           }
       }
       
     func loadTour(tourUID: String, completion: @escaping (Result<Tour?, TourError>) -> Void) {
           db.collection("tours").document(tourUID)
               .addSnapshotListener { (documentSnapshot, error) in
                   guard let document = documentSnapshot?.data() else { return completion(.failure(.noTourFound))}
                   
                   do {
                       let tour = try FirebaseDecoder().decode(Tour.self, from: document)
                       print(tour)
                       return completion(.success(tour))
                   } catch let error {
                       print(error)
                       return completion(.failure(.couldNotUnwrapTour))
                   }
             }
       }
     */
}
