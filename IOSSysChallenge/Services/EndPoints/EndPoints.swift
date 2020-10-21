//
//  EndPoints.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 20/10/20.
//

import Foundation

enum EndPoints {
    case login, research
    
    static var domain = "https://empresas.ioasys.com.br/api"
    static var apiVersion = "/v1"
    
    var path: String {
        switch self {
        case .login:
            return "\(EndPoints.domain)\(EndPoints.apiVersion)/users/auth/sign_in"
        case .research:
            return ""
        }
    }
}
