//
//  CompanyModel.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 21/10/20.
//

import Foundation

struct CompanyModel: Codable {
    var enterprise: Enterprise?
}

struct Enterprise: Codable {
    var id: Int?
    var enterpriseName: String?
    var description: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, description
        case enterpriseName = "enterprise_name"
    }
}
