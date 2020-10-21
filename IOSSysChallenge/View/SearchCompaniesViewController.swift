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
    
    // MARK: - View Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        navigationController?.isNavigationBarHidden = true
        
        searchCompaniesViewModel.getCompany(completion: { response in
            
        })
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource -

extension SearchCompaniesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
