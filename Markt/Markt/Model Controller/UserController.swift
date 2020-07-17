//
//  UserController.swift
//  Markt
//
//  Created by Jordan Furr on 6/21/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import CodableFirebase
import FirebaseAuth

struct UserKeys {
    static let emailKey = "email"
    static let firstKey = "firstName"
    static let lastKey = "lastName"
    static let uidKey = "uid"
    static let profilePicUID = "profilePicUID"
    static let myListings = "myListings"
    static let savedListings = "savedListings"
    static let dropOffKey = "dropOff"
    static let campusLocationKey = "campusLocation"
}

class UserController {
    
    static let shared = UserController()
    let db = Firestore.firestore()
    let storage = Storage.storage()
    lazy var storageRef = storage.reference()
    let usersRef : CollectionReference = Firestore.firestore().collection("users")
    
    var currentUser: User?
    
    func saveListing(listingID: String){
        guard let user = currentUser else {return}
           let userDoc = usersRef.document(user.uid)
           var savedListings = user.savedListings
           savedListings.append(listingID)
           let data = [
               "\(UserKeys.savedListings)" : savedListings as [String]
           ]
           userDoc.setData(data, merge: true) { (error) in
               if let error = error {
                   print(error.localizedDescription)
               }
           }
        self.updatedUser()
       }
    
    func unSaveListing(listingID: String){
     guard let user = currentUser else {return}
        let userDoc = usersRef.document(user.uid)
        var savedListings = user.savedListings
        guard let index = savedListings.firstIndex(of: listingID) else {return}
        savedListings.remove(at: index)
        let data = [
            "\(UserKeys.savedListings)" : savedListings as [String]
        ]
        userDoc.setData(data, merge: true) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        self.updatedUser()
    }
    
    func addCreatedListing(listingID: String){
        guard let user = currentUser else {return}
        let userDoc = usersRef.document(user.uid)
        var myListings = user.myListings
        myListings.append(listingID)
        let data = [
            "\(UserKeys.myListings)" : myListings as [String]
        ]
        userDoc.setData(data, merge: true) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        self.updatedUser()
    }
    
    func deleteListing(listingID: String){
     guard let user = currentUser else {return}
        let userDoc = usersRef.document(user.uid)
        var myListings = user.myListings
        guard let index = myListings.firstIndex(of: listingID) else {return}
        myListings.remove(at: index)
        let data = [
            "\(UserKeys.myListings)" : myListings as [String]
        ]
        userDoc.setData(data, merge: true) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        self.updatedUser()
    }
    
    func updateUserInfo(uid: String, email: String, firstName: String, lastName: String, dropOff: Bool, campusLocation: Int) {
        let userDoc = usersRef.document(uid)
        let data = [
            "\(UserKeys.firstKey)" : "\(firstName)",
            "\(UserKeys.lastKey)" : "\(lastName)",
            "\(UserKeys.uidKey)" : "\(uid)",
            "\(UserKeys.dropOffKey)" : dropOff,
            "\(UserKeys.campusLocationKey)" : campusLocation as Int
            ] as [String : Any]
        userDoc.setData(data, merge: true) { (error) in
            if let error = error { print(error) }
            else {
                print("success updating user")
                self.updatedUser()
            }
        }
    }
    
    func initUser(uid: String) {
           let userDoc = usersRef.document(uid)
           let data = [
               "\(UserKeys.myListings)" : [] as [String],
               "\(UserKeys.savedListings)" : [] as [String],
               "\(UserKeys.dropOffKey)" : false,
               "\(UserKeys.campusLocationKey)" : 0 as Int
               ] as [String : Any]
           userDoc.setData(data, merge: true) { (error) in
               if let error = error {
                  print(error)
               } else {
                self.updatedUser()
               }
           }
       }
    
    func updatedUser() {
        self.fetchCurrentUser { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case.success(let user):
                print("Successfully updated user")
                self.currentUser = user
            }
        }
    }
    
    func fetchCurrentUser(completion: @escaping (Result<User?, UserError>) -> Void) {
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            print("no current user")
            return completion(.failure(.noUserFound)) }
        let userDoc = usersRef.document(currentUserId)
        userDoc.getDocument { (snapshot, error) in
            if snapshot != nil {
                guard let snapshot = snapshot else { return completion(.failure(.noUserFound)) }
                guard let data = snapshot.data() else { return completion(.failure(.couldNotUnwrapUser)) }
                print(currentUserId)
                let user = try! FirestoreDecoder().decode(User.self, from: data)
                self.currentUser = user
                return completion(.success(user))
            } else {
                print("snapshot is nil")
                return completion(.failure(.noRecordFound))
            }
        }
    }
    
    func updateUserData(userID: String, data: [String: Any]){
        usersRef.document(userID).updateData(data) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                self.updatedUser()
            }
        }
    }
    
    func signoutCurrentUser() {
        try! Auth.auth().signOut()
        currentUser = nil
    }
    
    func sendResetPasswordLink(withEmail: String) {
        Auth.auth().sendPasswordReset(withEmail: withEmail) { (error) in
            if error == nil {
                print(error ?? "error"
                )
            } else {
                print("sent email to reset password")
            }
        }
    }
    
    
    func signup(firstName: String, lastName: String, email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error{
                print("Error in \(#function) : \(error.localizedDescription) /n--/n \(error)")
                completion(false, error)
            }
            guard let user = user else {return}
            let currentUser = Auth.auth().currentUser;
            print(" User Created \(user)")
            let values = ["email": email, "uid": currentUser?.uid, "firstName" : firstName, "lastName" : lastName]
            self.db.collection("users").document(currentUser!.uid).setData(values as [String : Any])
            completion(true, nil)
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Bool, Error?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            if let error = error {
                return completion(false, error)
            }
            print("login success")
            return completion(true, nil)
        }
    }
    
    func uploadPhoto(imageData: Data, objectUID: String, completion: @escaping (String?) -> Void) {
        guard let currentUser = Auth.auth().currentUser else { print("Image Failed to upload"); return }
        
        let imageName = UUID().uuidString
        let userDoc = UserController.shared.usersRef.document(currentUser.uid)
        let userData = ["profilePicUID" : imageName]
        userDoc.setData(userData, merge: true) { (error) in
        }
        let imageReference = storageRef.child("\(currentUser.uid)/\(objectUID)").child(imageName)
        imageReference.putData(imageData, metadata: nil) { (metaData, error) in
            if error != nil {
                print("Error uploading Image")
            }
            imageReference.downloadURL(completion: { (url, error) in
                if error != nil {
                    print("Error uploading Image")
                }
                guard let url = url else { return }
                completion(url.absoluteString)
            })
        }
    }
    
    func downloadPhoto(urlPath: String, completion: @escaping (Result<UIImage?, ImageError>) -> Void) {
        let locationImageReference = storageRef.child(urlPath)
        locationImageReference.getData(maxSize: 1000000) { (data, error) in
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
