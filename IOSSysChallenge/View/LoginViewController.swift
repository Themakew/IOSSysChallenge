//
//  LoginViewController.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 19/10/20.
//

import UIKit

// MARK: -

class LoginViewController: UIViewController {
    
    // MARK: - Properties -
    
    @IBOutlet weak var tableView: UITableView!
    
    private var isToCompressHeaderView: Bool = false
    
    // MARK: - View Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        tableView.register(HeaderCell.fromNib, forHeaderFooterViewReuseIdentifier: HeaderCell.identifier)
    }
    
    // MARK: - Private Methods -
    
    private func updateUI() {
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource -

extension LoginViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
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
        if indexPath.row == 2 {
            return 112.0
        }
        return 86.0
    }
}
