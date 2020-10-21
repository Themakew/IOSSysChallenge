//
//  SearchCompaniesViewController.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 21/10/20.
//

import UIKit

// MARK: -

final class SearchCompaniesViewController: UIViewController {
    
    // MARK: - Properties -
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var searchCompaniesViewModel = SearchCompaniesViewModel(httpManager: HTTPManager(session: URLSession.shared))
    private var tableViewList: [CompanyModel] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - View Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        tableView.register(CompanyTableViewCell.fromNib, forCellReuseIdentifier: CompanyTableViewCell.identifier)
        
        searchBar.delegate = self
        
        infoLabel.text = ""
        navigationController?.isNavigationBarHidden = true
        
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        if let row = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: row, animated: false)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource -

extension SearchCompaniesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = tableViewList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CompanyTableViewCell.identifier, for: indexPath) as! CompanyTableViewCell
        
        cell.bind(object: cellData.enterprise?.enterpriseName ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = CompanyDetailViewController(object: tableViewList[indexPath.row])
        navigationController?.pushViewController(viewController, animated: false)
    }
}

// MARK: - UISearchBarDelegate -

extension SearchCompaniesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !(searchBar.text?.isEmpty ?? false) {
            // Here I am using this endpoint just for test, the other endpoint
            // does not sent any json, so I chose this one to present at least
            // one company.
            
            searchCompaniesViewModel.getCompany(completion: { response in
                switch response {
                case .failure(let error):
                    Utils.alert(self, error.localizedDescription)
                case let .success(responseObject, _, _):
                    DispatchQueue.main.async {
                        self.tableViewList = []
                        self.tableViewList.append(responseObject!)
                        self.tableView.reloadData()
                        self.infoLabel.text = "\(self.tableViewList.count) resultado(s) encontrado(s)"
                        searchBar.resignFirstResponder()
                    }
                }
            })
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        view.endEditing(false)
    }
}
