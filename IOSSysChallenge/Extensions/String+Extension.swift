//
//  String+Extension.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 20/10/20.
//

import Foundation

// MARK: -

extension String {
    
    // MARK: - Public Methods -
    
    func text(comment: String = "", suffix: String = "") -> String {
        return "\(NSLocalizedString(self, tableName: "IOSSysChallenge", bundle: Bundle.main, comment: comment))\(suffix)"
    }
    
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
}
