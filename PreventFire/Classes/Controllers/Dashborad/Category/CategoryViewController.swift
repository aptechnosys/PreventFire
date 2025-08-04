//
//  CategoryViewController.swift
//  PreventFire
//
//  Created by Shantaram Kokate on 2/1/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit

class CategoryViewController: AbstractViewController {

    // MARK: - IBOutlet

    @IBOutlet weak var categoryTableView: UITableView!
    
    // MARK: - Properties

    var categoryList = [Catinfo]()
    var completionHandler: ((Catinfo, Bool) -> Void)?
    static let cellHeight: CGFloat = 120.0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
        callCategoryListAPI()
        categoryTableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func actionCompletionHandler(action:@escaping (Catinfo, Bool) -> Void) {
        self.completionHandler = action
    }
}

// MARK: - Configure UI

extension CategoryViewController {
    
    private func configureUI() {
        setupUIComponents()
    }
    
    private func setupUIComponents() {
        setupTableView()
       //self setupNavigationBar()
    }
    
    private func setupTableView() {
        categoryTableView.backgroundColor = .clear
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: CellIdentifier.categoryCell)
    }
    
    private func setupNavigationBar() {
        setTransparentNavigationBar()
        setNavBarTitle(LocalizedStrings.category)
        addbackButton()
    }
}

// MARK: - UITable DataSource

extension CategoryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CategoryCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.categoryCell, for: indexPath as IndexPath) as? CategoryCell else {
            fatalError()
        }
        cell.setData(categoryList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CategoryCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

}

// MARK: - UITable Delegate

extension CategoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.completionHandler!(categoryList[indexPath.row], false)
        self.navigationController?.popViewController(animated: true)
    }
}
// MARK: - WebServices

extension CategoryViewController {
    
    func callCategoryListAPI() {
        
        if !NetworkPreferences.isInternetConnectionAvailable() {
            showAlert(message: AlertMessage.noInternet, inViewController: self)
            return
        }
        showLoader()
        //let userId = SessionData.userId
        ServiceRequestClient.category(serviceRequestRouter: ServiceRequestRouter.category(id: ""),
                                                successCompletion: { (result) in
                                                    self.categoryList = result.catinfo!
                                                    self.categoryTableView.reloadData()
                                                    dismissLoader()
        }, failureCompletion: { (error) in
            if let errorDetail  = error.general?[0] {
                showAlert(message: errorDetail.message!, inViewController: self)
            }
            dismissLoader()
        })
    }
}
