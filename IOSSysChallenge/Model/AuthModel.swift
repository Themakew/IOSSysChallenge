//
//  AuthModel.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 21/10/20.
//

import Foundation

// MARK: -

struct AuthModel: Codable {
    
    // MARK: - Properties -
    
    var password: String
    var client: String
    var token: String
    var email: String
    var uid: String {
        return self.email
    }
}
