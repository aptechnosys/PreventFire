//
//  MagazineDetailViewController.swift
//  PreventFire
//
//  Created by Shantaram Kokate on 2/1/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit

class MagazineDetailViewController: AbstractViewController {

    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
        //fetchAllComplaintsList()
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

extension MagazineDetailViewController {

    private func configureUI() {
        setupUIComponents()
    }

    private func setupUIComponents() {
        setupNavigationBar()
        initializeLabels()
    }


    private  func setupNavigationBar() {
        if isFromMenuView {
            addLeftMenuItem()
            setTransparentNavigationBar()
            setNavigationBarTitle(LocalizedStrings.magazineDetail)
            configureNavbarTitle(LocalizedStrings.magazineDetail)

        } else {
            setTransparentNavigationBar()
            setNavBarTitle(LocalizedStrings.magazineDetail)
            addbackButton()
        }
    }

    func initializeLabels() {
        let des = """
A Marie Claire spokeswoman told the BBC that Marie Claire operated in a challenging fashion and beauty sector and that "consumers and advertisers have accelerated their move to digital alternatives".A Marie Claire spokeswoman told the BBC that Marie Claire operated in a challenging fashion and beauty sector and that "consumers and advertisers have accelerated their move to digital alternatives".A Marie Claire spokeswoman told the BBC that Marie Claire operated in a challenging fashion and beauty sector and that "consumers and advertisers have accelerated their move to digital alternatives".A Marie Claire spokeswoman told the BBC that Marie Claire operated in a challenging fashion and beauty sector and that "consumers and advertisers have accelerated their move to digital alternatives".A Marie Claire spokeswoman told the BBC that Marie Claire operated in a challenging fashion and beauty sector and that "consumers and advertisers have accelerated their move to digital alternatives".A Marie Claire spokeswoman told the BBC that Marie Claire operated in a challenging fashion and beauty sector and that "consumers and advertisers have accelerated their move to digital alternatives".A Marie Claire spokeswoman told the BBC that Marie Claire operated in a challenging fashion and beauty sector and that "consumers and advertisers have accelerated their move to digital alternatives".A Marie Claire spokeswoman told the BBC that Marie Claire operated in a challenging fashion and beauty sector and that "consumers and advertisers have accelerated their move to digital alternatives".
"""
        let title = "McConnell promises an 'orderly' transition of power"

        titleLabel.configureLabel(title: title, color: .red, font: FontStyle(family: .poppins, type: .semiBold, size: .pt14), alignment: .left)
        descriptionLabel.configureLabel(title: des, color: .black, font: FontStyle(family: .poppins, type: .regular, size: .pt14), alignment: .left)

    }

}

// MARK: - WebServices

extension MagazineDetailViewController {


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
