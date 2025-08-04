//
//  AlertViewController.swift
//  PreventFire
//
//  Created by Shantaram Kokate on 2/7/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit
import ESPullToRefresh
import SDWebImage

class AlertViewController: AbstractViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var resolvedButton: UIButton!
    @IBOutlet weak var unResolvedButton: UIButton!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var resolvedLabel: UILabel!
    @IBOutlet weak var unRresolvedLabel: UILabel!
    
    // MARK: - Properties
    var alertList = [AlertConcern]()

    // MARK: - VLC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
        callAlertListApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavbarTitle(LocalizedStrings.alerts)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
}

// MARK: - Configure UI

extension AlertViewController {
    
    private func configureUI() {
        setupUIComponents()
    }
    
    private func setupUIComponents() {
        setupTableView()
        setupNavigationBar()
    }
    
    
    private  func setupNavigationBar() {
        if isFromMenuView {
            addLeftMenuItem()
            setTransparentNavigationBar()
            setNavigationBarTitle(LocalizedStrings.alerts)
            configureNavbarTitle(LocalizedStrings.alerts)
            
        } else {
            setTransparentNavigationBar()
            setNavBarTitle(LocalizedStrings.alerts)
            addbackButton()
        }
    }
    
    
    private func setupTableView() {
        listTableView.backgroundColor = .clear
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(UINib(nibName: "UnResolvedComplaintCell", bundle: nil), forCellReuseIdentifier: CellIdentifier.unResolvedComplaintCell)
    }
}
// MARK: - Action

extension AlertViewController {
    
    @IBAction func addButtonTapped(_ sender: Any) {
        loadConcernRequestScreen()
    }
    
    func loadConcernRequestScreen() {
        let storyboard = UIStoryboard(name: StoryBoardName.serviceRequest.rawValue, bundle: Bundle.main)
        let concernRequestViewController = storyboard.instantiateViewController(withIdentifier: "ConcernRequestViewController") as? ConcernRequestViewController
        concernRequestViewController?.isFromMenuView = false
        self.navigationController?.pushViewController(concernRequestViewController!, animated: true)
    }
}
// MARK: - UITable DataSource

extension AlertViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alertList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: UnResolvedComplaintCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.unResolvedComplaintCell, for: indexPath as IndexPath) as? UnResolvedComplaintCell else {
            fatalError()
        }
        let consent  = alertList[indexPath.row]
        cell.setData(consent:consent)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UnResolvedComplaintCell.cellHeight
    }
}

// MARK: - UITable Delegate

extension AlertViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _  =  alertList[indexPath.row]
    }
}

// MARK: - Methods

extension AlertViewController {
    
    func callAlertListApi() {
        
        if !NetworkPreferences.isInternetConnectionAvailable() {
            showAlert(message: AlertMessage.noInternet, inViewController: self)
            return
        }
        showLoader()
        let userId = SessionData.userId
        ServiceRequestClient.alertList(serviceRequestRouter: ServiceRequestRouter.alert(userId: userId),
                                       successCompletion: { (result) in
                                        self.alertList = result.concern ?? []
                                        self.listTableView.reloadData()
                                        dismissLoader()
        }, failureCompletion: { (error) in
            dismissLoader()
            if let errorDetail  = error.general?[0] {
                showAlert(message: errorDetail.message!, inViewController: self)
            }
        })
    }
}
