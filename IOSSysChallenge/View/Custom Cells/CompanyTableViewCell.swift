//
//  CompanyTableViewCell.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 21/10/20.
//

import UIKit

// MARK: -

final class CompanyTableViewCell: UITableViewCell {

    // MARK: - Properties -
    
    @IBOutlet weak var backgroundCell: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "CompanyTableViewCell"
    static let fromNib = UINib(nibName: identifier, bundle: .main)
    
    // MARK: - View Lifecycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundCell.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Public Methods -
    
    func bind(object: String) {
        titleLabel.text = object
    }
}
