//
//  UIScreen+Extension.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 21/10/20.
//

import UIKit

// MARK: -

extension UIScreen {

    // MARK: - Enum -
    
    enum SizeType: CGFloat {
        case Unknown = 0.0
        case iPhone6 = 1334.0
    }

    // MARK: - Properties -
    
    var sizeType: SizeType {
        let height = nativeBounds.height
        guard let sizeType = SizeType(rawValue: height) else { return .Unknown }
        return sizeType
    }
}
