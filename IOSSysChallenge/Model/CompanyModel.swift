//
//  CompanyModel.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 21/10/20.
//

import Foundation

// MARK: -

struct CompanyModel: Codable {
    
    // MARK: - Properties -
    
    var enterprise: Enterprise?
}

// MARK: -

struct Enterprise: Codable {
    
    // MARK: - Properties -
    
    var id: Int?
    var enterpriseName: String?
    var description: String?
    
    // MARK: - Enum -
    
    private enum CodingKeys: String, CodingKey {
        case id, description
        case enterpriseName = "enterprise_name"
    }
}
