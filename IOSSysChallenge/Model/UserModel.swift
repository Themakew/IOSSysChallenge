//
//  UserModel.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 20/10/20.
//

import Foundation

// MARK: -

struct UserModel: Codable {
    var success: Bool?
    var investor: Investor?
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
