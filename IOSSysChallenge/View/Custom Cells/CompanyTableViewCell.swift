//
//  CompanyTableViewCell.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 21/10/20.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundCell: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundCell.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bind(object: String) {
        titleLabel.text = object
    }
}
