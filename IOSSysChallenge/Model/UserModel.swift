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
            return (false, "inform_your_email".text())
        } else if !email.isValidEmail() {
            return (false, "inform_a_valid_email".text())
        } else {
            return (true, "")
        }
    }
    
    static func validate(password: String) -> (result: Bool, error: String) {
        if password.isEmpty {
            return (false, "inform_your_password".text())
        } else if password.count < 4 {
            return (false, "inform_a_valid_password".text())
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
