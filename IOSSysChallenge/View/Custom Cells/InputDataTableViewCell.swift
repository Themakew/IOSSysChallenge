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

// MARK: - Protocol -

protocol InputDataTableViewCellDelegate {
    func didEnteredData(textField: UITextField, isHasError: Bool)
    func didBeginEditing(textField: UITextField)
}

// MARK: -

class InputDataTableViewCell: UITableViewCell {

    // MARK: - Properties -
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var textFieldIcon: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    
    private var isPasswordHidden: Bool = true
    private var cellType: InputCellType?
    
    var delegate: InputDataTableViewCellDelegate?
    
    static let identifier = "InputDataTableViewCell"
    static let fromNib = UINib(nibName: identifier, bundle: .main)
    
    // MARK: - View Lifecycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        inputTextField.layer.cornerRadius = 4
        inputTextField.tintColor = .black
        inputTextField.delegate = self
        
        errorLabel.isHidden = true
        
        setNormalState()
        addTap()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Public Methods -
    
    func bind(object: InputTextField) {
        titleLabel.text = object.title
        inputTextField.tag = object.id
        cellType = object.textFieldType
        
        setInputType(type: object.textFieldType)
    }
    
    func setErrorState(errorMessage: String) {
        textFieldIcon.image = UIImage(named: "password_error")
        
        inputTextField.layer.borderWidth = 1
        inputTextField.layer.borderColor = UIColor(red: 0.88, green: 0.00, blue: 0.00, alpha: 1.00).cgColor
        
        errorLabel.text = errorMessage
        errorLabel.isHidden = false
    }
    
    func setNormalState() {
        if isPasswordHidden {
            textFieldIcon.image = UIImage(named: "password_not_visible")
        } else {
            textFieldIcon.image = UIImage(named: "password_visibility")
        }
        
        inputTextField.layer.borderWidth = 0
        inputTextField.layer.borderColor = .none
        
        errorLabel.text = ""
        errorLabel.isHidden = true
    }
    
    // MARK: - Private Methods -
    
    private func addTap() {
        let imageIconTap = UITapGestureRecognizer(target: self, action: #selector(inputImageTap))
        textFieldIcon.isUserInteractionEnabled = true
        textFieldIcon.addGestureRecognizer(imageIconTap)
    }
    
    private func setInputType(type: InputCellType) {
        switch type {
        case .email:
            textFieldIcon.isHidden = true
            configEmailKeyboard()
        case .password:
            textFieldIcon.isHidden = false
            inputTextField.isSecureTextEntry = isPasswordHidden
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
        if isPasswordHidden {
            textFieldIcon.image = UIImage(named: "password_not_visible")
            isPasswordHidden = false
        } else {
            textFieldIcon.image = UIImage(named: "password_visibility")
            isPasswordHidden = true
        }
        
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
                    delegate?.didEnteredData(textField: textField, isHasError: false)
                } else {
                    setErrorState(errorMessage: InputModel.validate(email: inputText).error)
                    delegate?.didEnteredData(textField: textField, isHasError: true)
                }
            }
        } else {
            if let inputText = textField.text {
                if InputModel.validate(password: inputText).result {
                    setNormalState()
                    delegate?.didEnteredData(textField: textField, isHasError: false)
                } else {
                    setErrorState(errorMessage: InputModel.validate(password: inputText).error)
                    delegate?.didEnteredData(textField: textField, isHasError: true)
                }
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.didBeginEditing(textField: textField)
    }
}
