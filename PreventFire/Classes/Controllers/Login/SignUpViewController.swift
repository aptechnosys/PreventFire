//
//  SignUpViewController.swift
//  PreventFire
//
//  Created by Sharad Katre on 31/01/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit
import DropDown

class SignUpViewController: AbstractViewController {
    
    @IBOutlet weak var userImageButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var userImageContainerView: UIView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var countryCodeTextField: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    @IBOutlet weak var titleLabel: UILabel!
    
    var didImageUploaded = false
    var imageId: String = ""
    
    let paymentModeDropDown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
            self.paymentModeDropDown
        ]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
        callCountryListAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // self.configureNavbarLeftButton(imageName: "back_white")
        self.addbackButton()

    }

  
}

// MARK: - Configure UI

extension SignUpViewController {
    
    private func configureUI() {
        setupUIComponents()
        setupTextFields()
        setupButtons()
        setupDropDown()
        setupLabels()
    }
    
    private func setupUIComponents() {
        self.setupNavigationBar()
        self.addbackButton()
    }
    
    private func setupLabels() {
        self.titleLabel.configureLabel(title: LocalizedStrings.fireSafeIndiaFoundation, color: AppColor.Label.logoTitle, font: FontStyle(family: .poppins, type: .medium, size: .pt16), alignment: .center)
    }
    
    private func setupTextFields() {
        firstNameTextField.configureDarkThemeTextField(text: LocalizedStrings.firstNameText, delegate: self)
        lastNameTextField.configureDarkThemeTextField(text: LocalizedStrings.lastNameText, delegate: self)
        emailTextField.configureDarkThemeTextField(text: LocalizedStrings.emailAddress, delegate: self)
        mobileNumberTextField.configureDarkThemeTextField(text: LocalizedStrings.mobileNoText, delegate: self)
        passwordTextField.configureDarkThemeTextField(text: LocalizedStrings.passwordText, delegate: self)
        confirmPasswordTextField.configureDarkThemeTextField(text: LocalizedStrings.confirmPassword, delegate: self)
        firstNameTextField.addLeftImage(name: "name")
        lastNameTextField.addLeftImage(name: "name")
        emailTextField.addLeftImage(name: "email")
        mobileNumberTextField.addLeftImage(name: "mobile")
        passwordTextField.addLeftImage(name: "password")
        confirmPasswordTextField.addLeftImage(name: "password")
        
        countryCodeTextField.configureButtonWithTitle(title: LocalizedStrings.countryCode, titleColor: AppColor.TextField.placeholderColor, backgroundColor: AppColor.primaryColor, font: FontStyle(family: .poppins, type: .regular, size: .pt16))

    }
    
    private func setupButtons() {
        
        signInButton.configureButtonWithTitle(title: LocalizedStrings.registerText, titleColor: .white, backgroundColor: AppColor.Login.buttonBackgroundColor, font: FontStyle(family: .poppins, type: .regular, size: .pt16))
        
        userImageContainerView.backgroundColor = AppColor.primaryColor
        //userImageContainerView.layer.cornerRadius = userImageContainerView.bounds.width / 2
    }
    
    private func setupDropDown() {
        
        setupPaymentDropDown()
    }
    
    func setupPaymentDropDown() {
        
        paymentModeDropDown.anchorView = self.countryCodeTextField
        
        paymentModeDropDown.bottomOffset = CGPoint(x: 0, y: self.countryCodeTextField.bounds.height)
        
        paymentModeDropDown.dataSource = [
            "+91",
            "+92",
            "+1",
        ]
        
        paymentModeDropDown.direction = .bottom

        
        // Action triggered on selection
        paymentModeDropDown.selectionAction = { [weak self] (index, item) in
            self?.countryCodeTextField.setTitle(item, for: .normal)
           // self!.updateUI(selectedPaymentOption: item)
        }
    }
    
    
    private func setupNavigationBar() {
        addLeftNavigationBarButtonWithImage()
        setTransparentNavigationBar()
        setNavigationBarTitle(LocalizedStrings.registerText)
        self.configureNavbarLeftButton(imageName: "back_white")
    }
    
}
// MARK: - Action

extension SignUpViewController {
    @IBAction func userImageButtonTapped(_ sender: Any) {
        showCameraActionSheet()
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        if isValidInput() {
            callSignUpAPI()
        }
    }
    
    @IBAction func countryCodeButtonClicked(sender: UIButton) {
        paymentModeDropDown.show()
    }
    
}

// MARK: - Private methods

extension SignUpViewController {
    
    func showCameraActionSheet() {
        AttachmentHandler.shared.showAttachmentActionSheet(viewController: self)
        AttachmentHandler.shared.imagePickedBlock = { (image) in
            let chooseImage = image.resizeImage(targetSize: CGSize(width: 500, height: 600))
            self.userImageButton.setImage(chooseImage, for: .normal)
            self.callUploadImageAPI(chooseImage, handle: { (status) in
                print(status)
            })
        }
    }
    
    private func isValidInput() -> Bool {
        
        var isValid: Bool = true
       /* if self.didImageUploaded == false {
            showAlert(message: AlertMessage.uploadPictureValidation, inViewController: self)
            isValid = false
        } */
        if (firstNameTextField.text?.isEmpty)! {
            showAlert(message: AlertMessage.nameValidation, inViewController: self)
            isValid = false
        } else if (lastNameTextField.text?.isEmpty)! {
            showAlert(message: AlertMessage.lastNameValidation, inViewController: self)
            isValid = false
        } else if (emailTextField.text?.isEmpty)! {
            showAlert(message: AlertMessage.emailEmptyValidation, inViewController: self)
            isValid = false
        } else if (emailTextField.text?.isEmail)! == false {
            showAlert(message: AlertMessage.emailValidation, inViewController: self)
            isValid = false
        } else if (countryCodeTextField.titleLabel?.text?.isEmpty)! {
            showAlert(message: AlertMessage.countryCodeValidation, inViewController: self)
            isValid = false
        } else if (mobileNumberTextField.text?.isEmpty)! {
            showAlert(message: AlertMessage.mobileEmptyValidation, inViewController: self)
            isValid = false
        }  else if mobileNumberTextField.text?.isNumber() == false {
            showAlert(message: AlertMessage.mobileValidation, inViewController: self)
            isValid = true
        } else if passwordTextField.text?.isEmpty == true || confirmPasswordTextField.text?.isEmpty == true {
            showAlert(message: AlertMessage.passwordEmptyValidation, inViewController: self)
            isValid = false
        } else if passwordTextField.text != confirmPasswordTextField.text {
            showAlert(message: AlertMessage.confirmPasswordValidation, inViewController: self)
            isValid = false
        }
        return isValid
    }
    
    
    
    private func saveUserData(_ userModel: SignUp) {
        UserDefaults.standard.set(userName: firstNameTextField.text!)
        UserDefaults.standard.set(emilAddress: emailTextField.text!)
        UserDefaults.standard.set(mobileNumber: mobileNumberTextField.text!)
        UserDefaults.standard.set(imageUrl: imageId)
        let userId = String(describing: userModel.user_id!)
        UserDefaults.standard.set(userId: userId)
        UserDefaults.standard.set(userModel.google_map_key ?? "", forKey: Key.APIParameter.googleMapkey)
        UserDefaults.standard.set(lastName: self.lastNameTextField.text!)
        UserDefaults.standard.set(countryCode: (self.countryCodeTextField.titleLabel?.text!)!)
    }
}

//MARK: - Webservice

extension SignUpViewController {

    private func callUploadImageAPI(_ image: UIImage, handle:@escaping (Bool) -> Void) {
        
        showLoader()
        let imagedata = image.jpegData(compressionQuality: 1)
        
        let baseURL = APPURL.baseUrl()
        let url =  String(format: "%@%@", baseURL, APIEndpoint.uploadImage)
        
        let parameter: NSDictionary = ["ImgKey": imagedata as Any]
        
        let otherImages: [NSDictionary] = [["ImgKey": "photo", "ImgData": image]]
        
        ServiceRequestClient.uploadImageWithParameters(url: URL(string: url)!, parameters: parameter, otherImages: otherImages) { (dict, error, status) in
            if status == 200 {
                print(dict as Any)
                self.didImageUploaded = true
                print(dict as Any)
                self.imageId = dict!["photo"] as! String
            } else {
                self.userImageButton.setImage(#imageLiteral(resourceName: "addUser"), for: .normal)
                showAlert(message: AlertMessage.SomethingWentWrong, inViewController: self)
                
            }
            dismissLoader()
        }
    }
    
    func callSignUpAPI() {
        
        showLoader()
        var fcmToken = ""
        if let token =  UserDefaults.standard.value(forKey: DEVICETOKENKEY) as? String {
            fcmToken = token
        }
        let countryCode = self.countryCodeTextField.titleLabel?.text!
        
        LoginClient.signUp(loginRouter: LoginRouter.signup(name: firstNameTextField.text!, lastName: self.lastNameTextField.text!, password: passwordTextField.text!, access: "", status: "", mobile_no: mobileNumberTextField.text!, email_id: emailTextField.text!, photo: imageId, gcmid: fcmToken, device_id: UIDeviceUtils.getDeviceId(), language: UserDefaults.standard.getLanguage() ?? "English", countrycode: countryCode!), successCompletion: { (result) in
            
            if result.status! == 200 {
                self.saveUserData(result.message!)
                AppDelegate.delegate()?.setRootMenuViewController()
            } else {
                 showAlert(message: "Error! Something unexpected happened. Please try again later.", inViewController: self)
             }
           
            
            dismissLoader()
            
        }, failureCompletion: { (error) in
            
            print(error)
            
            dismissLoader()
            
        })
    }
    
    func callCountryListAPI() {
        
        if !NetworkPreferences.isInternetConnectionAvailable() {
            showAlert(message: AlertMessage.noInternet, inViewController: self)
            return
        }
        showLoader()
         LoginClient.countryList(loginRouter: LoginRouter.countryList,
                                                   successCompletion: { (result) in
                                                    dismissLoader()
                                                    if result.count != 0 {
                                                        self.paymentModeDropDown.dataSource = result.map { $0.countrycode ?? "" }
                                                     }
        }, failureCompletion: { (error) in
            dismissLoader()
            showAlert(message: error, inViewController: self)
         })
    }
}

// MARK: - UITextField Delegate

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       /* if textField == self.countryCodeTextField {
            self.countryCodeTextField.text = countryCodeList[0]
        } */
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          if textField == countryCodeTextField {
            let textFieldValidationModel = TextFieldRangeValidationModel(textField: textField, range: range, string: string, minLimit: 0, maxLimit: 3, replacingCharacter: "+")
            return textField.setTextfieldLimit(textFieldModel: textFieldValidationModel)
        }
        return true
    }
}
