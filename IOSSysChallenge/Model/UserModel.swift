//
//  UserModel.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 20/10/20.
//

import Foundation

// MARK: -

struct UserModel: Codable {
    
    // MARK: - Properties -
 
    var success: Bool?
    var investor: Investor?
    
    // MARK: - Static Methods -
    
    static func validate(email: String) -> (result: Bool, error: String) {
        if email.isEmpty {
            return (false, "Inform your email")
        } else if !email.isValidEmail() {
            return (false, "Inform a valid email")
        } else {
            return (true, "")
        }
    }
    
    static func validate(password: String) -> (result: Bool, error: String) {
        if password.isEmpty {
            return (false, "Informe your password")
        } else if password.count < 4 {
            return (false, "Inform a valid password")
        } else {
            return (true, "")
        }
    }
}

// MARK: -

struct Investor: Codable {
    
    // MARK: - Properties -
    
    var id: Int?
    var investorName: String?
    let email: String?
    let name: String?
    var photoUrl: String?
    
    // MARK: - Enum -
    
    private enum CodingKeys: String, CodingKey {
        case id, email, name, photoUrl
        case investorName = "investor_name"
    }
}
