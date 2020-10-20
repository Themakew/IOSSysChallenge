//
//  OneButtonTableViewCell.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 20/10/20.
//

import UIKit

// MARK: -

class OneButtonTableViewCell: UITableViewCell {

    // MARK: - Properties -
    
    @IBOutlet weak var buttonOne: UIButton!
    
    // MARK: - View Lifecycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buttonOne.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func bind() {
        buttonOne.setTitle("", for: .normal)
    }
}
