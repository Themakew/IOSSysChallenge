//
//  Utils.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 21/10/20.
//

import UIKit

// MARK: -

class Utils {
    
    // MARK: - Static Methods -
    
    static func alert(_ viewController: UIViewController, title: String? = nil, _ message: String, btnLabel: String? = nil, completion: (() -> ())? = nil, onOK: (() -> ())? = nil) {
        DispatchQueue.main.async {
            let cancelButton = UIAlertAction(title: btnLabel ?? "Ok".text(), style: .default, handler: { action in
                onOK?()
            })
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(cancelButton)
            
            viewController.present(alert, animated: true, completion: completion)
        }
    }
}
