//
//  FirebaseFunctions.swift
//  SlowmoGraham
//
//  Created by Noah Bissell (student LM) on 2/3/22.
//

import FirebaseFirestore
import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestoreSwift


struct FirebaseFunctions {
    static func getKitchensData(_userInfo : UserInfo, _ kitchens: Kitchens) {
        Auth.auth().addStateDidChangeListener { _, user in
            guard let user = user else {return}
            
            let uid = user.uid
            
            Firestore.firestore().collection("kitchens").addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                let kitchenList = documents.compactMap { queryDocumentSnapshot -> Kitchen? in
                    return try? queryDocumentSnapshot.data(as: Kitchen.self)
                }
                kitchens.kitchens = kitchenList
                
                //                guard let document = document else {return}
                //
                //                // getting information from the user's document
                //                let imageURL = document.get("image") as? String ?? ""
                ////                userInfo.name = document.get("username") as? String ?? ""
                ////
                ////                Storage.storage().reference(forURL: imageURL).getData(maxSize: 1 * 1024 * 1024) { data, _ in
                ////                    if let imageData = data {
                ////                        userInfo.image = UIImage(data: imageData) ?? UIImage(named: "user")!
                ////                    }
                ////                }
            }
        }
    }
    
    static func addKitchen(userInfo : UserInfo, kitchen: Kitchen, completion: @escaping (Bool) -> ()){
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }
        do {
            let _ = try Firestore.firestore().collection("kitchens").addDocument(from: kitchen)
            if let id = kitchen.kitchenId {
                userInfo.kitchenIds.append(id)
            }
            else {
                print("Kitchen has no id")
            }
        }
        catch {
            print(error)
        }
        //Firestore.firestore().collection("kitchens").document(uid).setData()
    }
    
    static func updateKitchen(userInfo: UserInfo, kitchen: Kitchen, completion: @escaping (Bool) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }
        if let id = kitchen.kitchenId {
            try? Firestore.firestore().collection("kitchens").document(id).setData(from: kitchen, merge: true)
            if !userInfo.kitchenIds.contains(id) {
                userInfo.kitchenIds.append(id)
            }
        }
        else {
            print("Kitchen has no id")
        }
    }
    
    static func getUserInfo(_ userInfo: UserInfo) {
        Auth.auth().addStateDidChangeListener { _, user in
            guard let user = user else {return}
            
            userInfo.email = user.email ?? ""
            userInfo.loggedIn = true
            
            let uid = user.uid
            
            Firestore.firestore().collection("users").document(uid).getDocument { document, _ in
                guard let document = document else {return}
                
                // getting information from the user's document
                let imageURL = document.get("image") as? String ?? ""
                userInfo.name = document.get("username") as? String ?? ""
                
//                Storage.storage().reference(forURL: imageURL).getData(maxSize: 1 * 1024 * 1024) { data, _ in
//                    if let imageData = data {
//                        userInfo.image = UIImage(data: imageData) ?? UIImage(named: "user")!
//                    }
//                }
            }
            
        }
    }
    
    static func signOut(_ userInfo: UserInfo) {
        try? Auth.auth().signOut()
        userInfo.loggedIn = false
        userInfo.password = ""
    }
    
    static func login(_ userInfo: UserInfo) {
        userInfo.email = "s015915@students.lmsd.org"
        userInfo.password = "00000000"
    }
    
    static func addUsername(username: String, completion: @escaping (Bool) -> ()){
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }
        
        Firestore.firestore().collection("users").document(uid).setData(["username": username], merge: true)
    }
    
    static func uploadPicture(image: UIImage, completion: @escaping (Bool) -> ()){
        // get the user's id. The image will be stored by this uid
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }
        
        // get a reference to the storage singleton.
        let storage = Storage.storage().reference().child("users/\(uid)")
        
        // convert the image to a form that can be stored in storage
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(false)
            return
        }
        
        storage.putData(imageData, metadata: StorageMetadata()) { meta, error in
            if let _ = meta {
                storage.downloadURL { url, error in
                    guard let downloadURL = url else {
                        completion(false)
                        return
                    }
                    Firestore.firestore().collection("users").document(uid).setData(["image": downloadURL.absoluteString], merge: true)
                }
            }
        }
    }
    
    static func authenticate (email : String, password : String, completion: @escaping (Bool) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if let _ = user {
                print("user created")
                completion(true)
                return
            }
            else {
                print(error.debugDescription)
                completion(false)
                return
            }
        }
    }
    
    static func login(email : String, password : String, completion: @escaping (Bool) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let _ = user {
                print("logged in")
                completion(true)
                return
            }
            else {
                print(error.debugDescription)
                completion(false)
                return
            }
        }
    }
    
    static func forgotPassword(email : String, completion : @escaping (Bool) -> ()) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let _ = error {
                completion(false)
                return
            }
            else {
                completion(true)
                return
            }
        }
    }
}
