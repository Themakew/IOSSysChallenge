//
//  LoginModel.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 20/10/20.
//

import UIKit

// MARK: - Protocol -

protocol LoginBaseProtocol {}

// MARK: -

struct InputTextField: LoginBaseProtocol {
    
    // MARK: - Properties -
    
    var title: String
    var textFieldType: InputCellType
    var isTextHidden: Bool = false
    var errorMessage: String = ""
}

struct LoginModel: Codable {
    var email: String
    var password: String
}
