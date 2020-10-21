//
//  CompanyDetailViewController.swift
//  IOSSysChallenge
//
//  Created by Ruyther Costa on 21/10/20.
//

import UIKit

// MARK: -

final class CompanyDetailViewController: UIViewController {
    
    // MARK: - Properties -
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var companyNameLbl: UILabel!
    @IBOutlet weak var companyDescriptionLbl: UILabel!
    
    private var companyData: CompanyModel
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    // MARK: - Init -
    
    init(object: CompanyModel) {
        self.companyData = object
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayoutInfo()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    // MARK: - Private Methods -
    
    private func setLayoutInfo() {
        navigationBar.topItem?.title = companyData.enterprise?.enterpriseName
        navigationBar.barTintColor = .white
        companyNameLbl.text = companyData.enterprise?.enterpriseName
        companyDescriptionLbl.text = companyData.enterprise?.description
    }
}

// MARK: - Extension -

extension CompanyDetailViewController {
    @IBAction
    func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: false)
    }
}
