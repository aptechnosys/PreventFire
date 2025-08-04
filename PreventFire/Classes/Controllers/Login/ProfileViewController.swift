//
//  ProfileViewController.swift
//  PreventFire
//
//  Created by Sharad Katre on 01/02/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit

class ProfileViewController: AbstractViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setUserDetails()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigationBarTitle(LocalizedStrings.profile)
        configureNavbarTitle(LocalizedStrings.profile)
        
    }
    
    func setUserDetails() {
        firstNameTextField.text = UserDefaults.standard.getUserName() ?? ""
        lastNameTextField.text = UserDefaults.standard.getLastName() ?? ""
        emailTextField.text = UserDefaults.standard.getEmailNumber() ?? ""
        let countryCode = UserDefaults.standard.getcountryCode() ?? "91"
        let mobileNumber = UserDefaults.standard.getMobileNumber() ?? ""
         var mobileWithCountryCode = ""
        if countryCode.isEmpty {
            mobileWithCountryCode = "+91 " + mobileNumber
        } else {
            mobileWithCountryCode = "+" + countryCode + " " + mobileNumber
        }
         mobileNumberTextField.text = mobileWithCountryCode

        let url = URL(string: UserDefaults.standard.getImageUrl() ?? "")
        self.userImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "addUser"), options: .refreshCached, completed: nil)
    }

}

extension ProfileViewController {
    private func configureUI() {
        setupUIComponents()
        setupTextFields()
        setupImageView()
        setupLabel()
    }
    
    private func setupLabel () {
     titleLabel.configureLabel(title: LocalizedStrings.fireSafeIndiaFoundation, color: AppColor.Label.logoTitle, font: FontStyle(family: .poppins, type: .medium, size: .pt16), alignment: .center)
    }
    
    private func setupUIComponents() {
        self.setupNavigationBar()
    }
    
    private func setupImageView() {
        userImageView.image = #imageLiteral(resourceName: "placeholder-profile-picture-icon-1")
        userImageView.layer.cornerRadius = 5.0
    }
    
    private func setupTextFields() {
        firstNameTextField.configureDarkThemeTextField(text: LocalizedStrings.nameText, delegate: self)
        lastNameTextField.configureDarkThemeTextField(text: LocalizedStrings.nameText, delegate: self)
        emailTextField.configureDarkThemeTextField(text: LocalizedStrings.emailAddress, delegate: self)
        mobileNumberTextField.configureDarkThemeTextField(text: LocalizedStrings.mobileNoText, delegate: self)
        firstNameTextField.addLeftImage(name: "name")
        lastNameTextField.addLeftImage(name: "name")
        emailTextField.addLeftImage(name: "email")
        mobileNumberTextField.addLeftImage(name: "mobile")
        
        firstNameTextField.isUserInteractionEnabled = false
        emailTextField.isUserInteractionEnabled = false
        mobileNumberTextField.isUserInteractionEnabled = false
        lastNameTextField.isUserInteractionEnabled = false

    }

    private func setupNavigationBar() {
        if isFromMenuView {
            addLeftMenuItem()
            setTransparentNavigationBar()
            setNavigationBarTitle(LocalizedStrings.profile)
            configureNavbarTitle(LocalizedStrings.profile)

        } else {
            setTransparentNavigationBar()
            setNavBarTitle(LocalizedStrings.profile)
            addbackButton()
        }
    }
}
