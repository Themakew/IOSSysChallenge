//
//  OneButtonTableViewCell.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 20/10/20.
//

import UIKit

// MARK: - OneButtonTableViewCellDelegate -

protocol OneButtonTableViewCellDelegate {
    func didClickButton()
}

// MARK: -

class OneButtonTableViewCell: UITableViewCell {

    // MARK: - Properties -
    
    @IBOutlet weak var buttonOne: UIButton!
    
    static let identifier = "OneButtonTableViewCell"
    static let fromNib = UINib(nibName: identifier, bundle: .main)
    
    var delegate: OneButtonTableViewCellDelegate?
    
    // MARK: - View Lifecycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buttonOne.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Public Methods -
    
    func bind(object: OneButton) {
        buttonOne.setTitle(object.title, for: .normal)
        buttonOne.isEnabled = false
    }
}

// MARK: - Extension -

extension OneButtonTableViewCell {
    @IBAction
    func buttonAction(_ sender: Any) {
        delegate?.didClickButton()
    }
}
