//
//  AuthViewModel.swift
//  ToDo
//
//  Created by Josileudo on 11/30/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(
        withEmail email: String,
        password: String
    ) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("[DEBUG] Error, user not signin \(error.localizedDescription)")
        }
    }
    
    func createUser(
            withEmail email: String,
            username: String,
            password: String
    ) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, email: email, password: password, username: username)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        } catch {
            print("[Debug] Error for create an user \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("Error for SignOut \(error.localizedDescription)")
        }
        
    }
    
    func deleteUser() async throws {
        do {
            // MARK: Remove from the firestore
            guard let uid = Auth.auth().currentUser?.uid else { return }
            try? await Firestore.firestore().collection("users").document(uid).delete()
            
            // MARK: Remove from the Authentication
            let user = Auth.auth().currentUser
            try await user?.delete()
            
            // MARK: Make a signout for callback to the loginView
            self.signOut()
        } catch {
            print("Error for delete user \(error.localizedDescription)")
        }
        
    }
    
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        
        print("[Debug] currently user \(String(describing: self.currentUser))")
    }
    
    func updateUser() {
        
    }
}
