//
//  InputDataTableViewCell.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 20/10/20.
//

import UIKit

// MARK: - Enum -

enum InputCellType {
    case email, password
}

// MARK: -

class InputDataTableViewCell: UITableViewCell {

    // MARK: - Properties -
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var textFieldIcon: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    
    private var isPasswordHidden: Bool = false
    private var cellType: InputCellType?
    
    // MARK: - View Lifecycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        inputTextField.layer.cornerRadius = 4
        inputTextField.delegate = self
        
        addTap()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Public Methods -
    
    func bind(object: InputModel) {
        titleLabel.text = object.title
        inputTextField.tag = object.id
        cellType = object.cellType
        
        setInputType(type: object.cellType)
    }
    
    func setErrorState(errorMessage: String) {
        textFieldIcon.image = UIImage(named: "password_error")
        
        inputTextField.layer.borderWidth = 1
        inputTextField.layer.borderColor = UIColor(red: 0.88, green: 0.00, blue: 0.00, alpha: 1.00).cgColor
        
        errorLabel.text = errorMessage
    }
    
    func setNormalState() {
        textFieldIcon.image = UIImage(named: "password_visibility")
        
        inputTextField.layer.borderWidth = 0
        inputTextField.layer.borderColor = .none
        
        errorLabel.text = ""
    }
    
    // MARK: - Private Methods -
    
    private func addTap() {
        let imageIconTap = UITapGestureRecognizer(target: self, action: #selector(inputImageTap))
        inputTextField.addGestureRecognizer(imageIconTap)
    }
    
    private func setInputType(type: InputCellType) {
        switch type {
        case .email:
            configEmailKeyboard()
        case .password:
            configNumberKeyboard()
        }
    }
    
    private func configEmailKeyboard() {
        inputTextField.keyboardType = .emailAddress
    }
    
    private func configNumberKeyboard() {
        inputTextField.keyboardType = .numberPad
    }
}

// MARK: - Extension -

extension InputDataTableViewCell {
    @objc
    func inputImageTap() {
        if cellType != nil && cellType == .password {
            inputTextField.isSecureTextEntry = isPasswordHidden
        }
    }
}

// MARK: - UITextFieldDelegate -

extension InputDataTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            if let inputText = textField.text {
                if InputModel.validate(email: inputText).result {
                    setNormalState()
                } else {
                    setErrorState()
                }
            }
        } else {
            if let inputText = textField.text {
                if InputModel.validate(password: inputText).result {
                    setNormalState()
                } else {
                    setErrorState()
                }
            }
        }
    }
}
