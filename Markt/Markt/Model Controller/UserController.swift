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
}

class UserController {
    
    static let shared = UserController()
    let db = Firestore.firestore()
    let storage = Storage.storage()
    lazy var storageRef = storage.reference()
    let usersRef : CollectionReference = Firestore.firestore().collection("users")
    
    var currentUser: User?
    
    
    func updateUserInfo(email: String, completion: @escaping (Result<User?, UserError>) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        let userDoc = usersRef.document(currentUserID)
        let data = [
            "\(UserKeys.emailKey)" : "\(email)"
            ] as [String : Any]
        userDoc.setData(data, merge: true) { (error) in
            if let error = error {
                return completion(.failure(.firebaseError(error)))
            } else {
                let updatedUser = User(email: email)
                self.currentUser = updatedUser
                return completion(.success(updatedUser))
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
    
    
    func signup(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error{
                print("Error in \(#function) : \(error.localizedDescription) /n--/n \(error)")
                completion(false, error)
            }
            guard let user = user else {return}
            let currentUser = Auth.auth().currentUser;
            print(" User Created \(user)")
            let values = ["email": email, "uid": currentUser?.uid]
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
    
}
