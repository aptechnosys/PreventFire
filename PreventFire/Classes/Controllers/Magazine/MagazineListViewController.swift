//
//  MagazineListViewController.swift
//  PreventFire
//
//  Created by Shantaram Kokate on 2/1/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit

class MagazineListViewController: AbstractViewController {

    @IBOutlet weak var menuTableView: UITableView!

    var complaintsList = [Concern]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
        fetchAllComplaintsList()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - Configure UI

extension MagazineListViewController {

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
            setNavigationBarTitle(LocalizedStrings.magazine)
            configureNavbarTitle(LocalizedStrings.magazine)

        } else {
            setTransparentNavigationBar()
            setNavBarTitle(LocalizedStrings.magazine)
            addbackButton()
        }
    }

    private func setupTableView() {
        menuTableView.backgroundColor = .clear
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.register(UINib(nibName: "MagazineCell", bundle: nil), forCellReuseIdentifier: CellIdentifier.magazineCell)
        menuTableView.estimatedRowHeight = UnResolvedComplaintCell.cellHeight
        menuTableView.rowHeight = UITableView.automaticDimension
    }

    private func setupNavigationBarRightButton() {
        let button: UIButton = UIButton.init(type: .custom)
        button.setImage(#imageLiteral(resourceName: "add_icon"), for: .normal)
        button.isUserInteractionEnabled = true
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        let leftButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = leftButton
    }
}

// MARK: - UITable DataSource

extension MagazineListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MagazineCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.magazineCell, for: indexPath as IndexPath) as? MagazineCell else {
            fatalError()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }


}

// MARK: - UITable Delegate

extension MagazineListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushToMagazineDetailView()
    }
}

// MARK: - Methods

extension MagazineListViewController {

    private func fetchAllComplaintsList() {
        callServiceRequestListAPI { (consernList, error) in
            if !error {
                self.complaintsList = consernList?.concern ?? []
                self.menuTableView.reloadData()
            }
        }
    }

    func pushToMagazineDetailView() {
        let storyborad = UIStoryboard(name: StoryBoardName.magazine.rawValue, bundle: nil)
        let serviceDetailViewController = storyborad.instantiateViewController(withIdentifier: "MagazineDetailViewController") as? MagazineDetailViewController
        serviceDetailViewController?.isFromMenuView = true
        self.navigationController?.pushViewController(serviceDetailViewController!, animated: true)
    }

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

// MARK: - WebServices

extension MagazineListViewController {


    func callServiceRequestListAPI(completionHandler: @escaping(ConsernList?, Bool) -> Void) {

        if !NetworkPreferences.isInternetConnectionAvailable() {
            showAlert(message: AlertMessage.noInternet, inViewController: self)
            return
        }
        showLoader()
        let userId = SessionData.userId
        ServiceRequestClient.serviceRequestList(serviceRequestRouter: ServiceRequestRouter.allComplaints(userId: userId),
                                                successCompletion: { (result) in
                                                    completionHandler(result, false)
                                                    dismissLoader()
        }, failureCompletion: { (error) in
            dismissLoader()
            if let errorDetail  = error.general?[0] {
                showAlert(message: errorDetail.message!, inViewController: self)
            }
            completionHandler(nil, true)
        })
    }
}
