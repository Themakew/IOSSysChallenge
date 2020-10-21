//
//  LoginViewController.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 19/10/20.
//

import UIKit

// MARK: -

final class LoginViewController: UIViewController {
    
    // MARK: - Properties -
    
    @IBOutlet weak var tableView: UITableView!
    
    private var isToCompressHeaderView: Bool = false
    private var loginViewModel = LoginViewModel(httpManager: HTTPManager(session: URLSession.shared))
    private var tableViewList: [LoginBaseProtocol] = []
    private var inputEmailHasError: Bool = false
    private var inputPasswordHasError: Bool = false
    private var inputEmail: String = ""
    private var inputPassword: String = ""
    private var currentTextField: UITextField?
    
    // MARK: - View Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        navigationController?.isNavigationBarHidden = true
        
        tableView.register(HeaderCell.fromNib, forHeaderFooterViewReuseIdentifier: HeaderCell.identifier)
        tableView.register(InputDataTableViewCell.fromNib, forCellReuseIdentifier: InputDataTableViewCell.identifier)
        tableView.register(OneButtonTableViewCell.fromNib, forCellReuseIdentifier: OneButtonTableViewCell.identifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        getTableViewList()
    }
    
    // MARK: - Private Methods -
    
    private func updateUI() {
        tableView.reloadData()
    }
    
    private func getTableViewList() {
        tableViewList = loginViewModel.buildLoginList()
    }
}

// MARK: - Extension -

extension LoginViewController {
    @objc
    func keyboardWillShow(sender: NSNotification) {
        if UIScreen.main.sizeType == .iPhone6 {
            self.view.frame.origin.y = -60
        }
    }

    @objc
    func keyboardWillHide(sender: NSNotification) {
        if UIScreen.main.sizeType == .iPhone6 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc
    func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        currentTextField?.resignFirstResponder()
        
        let indexPath = IndexPath(row: 2, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! OneButtonTableViewCell
        cell.buttonOne.isEnabled = !inputEmailHasError && !inputPasswordHasError
        cell.reloadInputViews()
    }
}

// MARK: - InputDataTableViewCellDelegate -

extension LoginViewController: InputDataTableViewCellDelegate {
    func didBeginEditing(textField: UITextField) {
        currentTextField = textField
    }
    
    func didEnteredData(textField: UITextField, isHasError: Bool) {
        if textField.tag == 1 {
            inputEmail = textField.text ?? ""
            inputEmailHasError = isHasError
        } else {
            inputPassword = textField.text ?? ""
            inputPasswordHasError = isHasError
        }
    }
}

// MARK: - OneButtonTableViewCellDelegate -

extension LoginViewController: OneButtonTableViewCellDelegate {
    func didClickButton() {
        loginViewModel.makeLogin(request: loginViewModel.getLoginModelObject(email: inputEmail, password: inputPassword)) { response in
            switch response {
            case .failure(let error):
                Utils.alert(self, error.localizedDescription)
            case .success(_, _, _):
                DispatchQueue.main.async {
                    let viewController = SearchCompaniesViewController()
                    self.navigationController?.pushViewController(viewController, animated: false)
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource -

extension LoginViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = tableViewList[indexPath.row]
        
        if let inputCell = cellData as? InputTextField {
            let cell = tableView.dequeueReusableCell(withIdentifier: InputDataTableViewCell.identifier, for: indexPath) as! InputDataTableViewCell
            
            cell.bind(object: inputCell)
            cell.delegate = self
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: OneButtonTableViewCell.identifier, for: indexPath) as! OneButtonTableViewCell
            
            cell.delegate = self
            if let inputCell = cellData as? OneButton {
                cell.bind(object: inputCell)
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderCell.identifier)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if isToCompressHeaderView {
            return 100.0
        } else {
            return 140.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112.0
    }
}
