//
//  HeaderCell.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 19/10/20.
//

import UIKit

// MARK: -

final class HeaderCell: UITableViewHeaderFooterView {

    // MARK: - Properties -
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topLogoConstraint: NSLayoutConstraint!
    
    static let identifier = "HeaderCell"
    static let fromNib = UINib(nibName: "HeaderViewCell", bundle: .main)
    
    var isItSmaller: Bool = false

    // MARK: - View Lifecycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        handleCellCompression()
    }
    
    // MARK: - Private Methods -
    
    private func handleCellCompression() {
        if isItSmaller {
            titleLabel.isHidden = true
            topLogoConstraint.constant = 50
        } else {
            titleLabel.isHidden = false
            topLogoConstraint.constant = 80
        }
    }
}
