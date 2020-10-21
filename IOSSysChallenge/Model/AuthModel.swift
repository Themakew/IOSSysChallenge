//
//  AuthModel.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 21/10/20.
//

import Foundation

struct AuthModel: Codable {
    var password: String
    var client: String
    var token: String
    var email: String
    var uid: String {
        return self.email
    }
}
