//
//  ForgotPasswordViewController.swift
//  PreventFire
//
//  Created by Sharad Katre on 01/02/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: AbstractViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        if isValidInput() {
            callForgotPasswordAPI()
        }
    }
    
    private func isValidInput() -> Bool {
        
        var isValid: Bool = true
        
        if (emailTextField.text?.isEmpty)! {
            showAlert(message: AlertMessage.emailEmptyValidation, inViewController: self)
            isValid = false
        }
        return isValid
    }
    
    func callForgotPasswordAPI() {
        
        showLoader()
        
        LoginClient.forgotPassword(loginRouter: LoginRouter.forgotPassword(userName: emailTextField.text!), successCompletion: { (result) in
            
            dismissLoader()
            print(result)
//            showAlert(title: AlertMessage.success, message: (result.general?.first?.message)!, inViewController: self)
            
        }, failureCompletion: { (error) in
            
            print(error)
            
            dismissLoader()
            
        })
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func configureUI() {
        setupUIComponents()
        setupTextFields()
        setupTitleLabel()
        setupButtons()
    }
    
    private func setupUIComponents() {
        self.setupNavigationBar()
        self.addbackButton()
    }
    
    private func setupTitleLabel() {
        self.titleLabel.configureLabel(title: LocalizedStrings.fireSafeIndiaFoundation, color: AppColor.Label.logoTitle, font: FontStyle(family: .poppins, type: .medium, size: .pt16), alignment: .center)
    }
    
    private func setupTextFields() {
        emailTextField.configureDarkThemeTextField(text: LocalizedStrings.emailAddress, delegate: self)
        emailTextField.addLeftImage(name: "email")
    }
    
    private func setupButtons() {
        
        sendButton.configureButtonWithTitle(title: LocalizedStrings.submit, titleColor: .white, backgroundColor: AppColor.Login.buttonBackgroundColor, font: FontStyle(family: .poppins, type: .regular, size: .pt16))
        
    }
    
    private func setupNavigationBar() {
        addbackButton()
        setTransparentNavigationBar()
        setNavigationBarTitle(LocalizedStrings.forgotPassword)
        self.configureNavbarLeftButton(imageName: "back_white")
    }
    
}
