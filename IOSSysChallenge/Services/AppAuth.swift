//
//  AppAuth.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 21/10/20.
//

import Foundation

final class AppAuth {
    
    var auth: AuthModel?
    
    static let shared = AppAuth()
    
    func signIn(email: String, password: String, client: String, token: String) {
        let auth = AuthModel(password: password, client: client, token: token, email: email)
        self.auth = auth
        let archievedAuth = try? NSKeyedArchiver.archivedData(withRootObject: auth, requiringSecureCoding: false)
        UserDefaults.standard.setValue(archievedAuth, forKey: "auth")
    }
}
