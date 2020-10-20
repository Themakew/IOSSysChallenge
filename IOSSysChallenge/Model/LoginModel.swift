//
//  LoginModel.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 20/10/20.
//

import UIKit

protocol LoginBaseProtocol {}

struct InputTextField: LoginBaseProtocol {
    var title: String
    var textFieldType: InputCellType
    var isTextHidden: Bool = false
    var errorMessage: String = ""
}
