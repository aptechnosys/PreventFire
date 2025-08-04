import UIKit

class LoginViewController: AbstractViewController {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        // Do any additional setup after loading the view.
    }
    
}

// MARK: - Configure UI
extension LoginViewController {
    
    private func configureUI() {
        setupUIComponents()
        setupTextFields()
        setupButtons()
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
        emailTextField.configureDarkThemeTextField(text: LocalizedStrings.emailAddress, delegate: self)
        passwordTextField.configureDarkThemeTextField(text: LocalizedStrings.passwordText, delegate: self)
        
        emailTextField.addLeftImage(name: "email")
        passwordTextField.addLeftImage(name: "password")
        
        //emailTextField.text = "ashu548@yahoo.com"
        //passwordTextField.text = "Ashish@007"
        
        emailTextField.roundCorners(10)
    }
    
    private func setupButtons() {
        
       // facebookButton.isHidden = true
        
        signInButton.configureButtonWithTitle(title: LocalizedStrings.signInText, titleColor: .white, backgroundColor: AppColor.Login.buttonBackgroundColor, font: FontStyle(family: .poppins, type: .bold, size: .pt16))
        
        forgotPasswordButton.configureButtonWithTitle(title: LocalizedStrings.forgotPassword, titleColor: AppColor.primaryColor, backgroundColor: .clear, font: FontStyle(family: .poppins, type: .bold, size: .pt21))
        
        signUpButton.configureButtonWithTitle(title: LocalizedStrings.newHereSignUpText, titleColor: .red, backgroundColor: .clear, font: FontStyle(family: .poppins, type: .bold, size: .pt24))
        
    }
    
    private func setupNavigationBar() {
        setNavigationBarTitle(LocalizedStrings.loginText)
        self.navigationController?.navigationBar.isHidden = false
        setTransparentNavigationBar()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white]
        self.configureNavbarLeftButton(imageName: "back_white")
    }
    
}

// MARK: - Private Methods

extension LoginViewController {
    
    private func isValidInput() -> Bool {
        
        var isValid: Bool = true
        
        if (emailTextField.text?.isEmpty)! {
            showAlert(message: AlertMessage.emailEmptyValidation, inViewController: self)
            isValid = false
        } else if (emailTextField.text?.isEmail)! == false {
            showAlert(message: AlertMessage.emailValidation, inViewController: self)
            isValid = false
        } else if passwordTextField.text?.isEmpty == true {
            showAlert(message: AlertMessage.passwordEmptyValidation, inViewController: self)
            isValid = false
        }
        return isValid
    }
    
    private func saveUserData(_ userModel: Login) {
        UserDefaults.standard.set(emilAddress: userModel.email ?? "")
        UserDefaults.standard.set(mobileNumber: userModel.mobile_no ?? "")
        UserDefaults.standard.set(imageUrl: userModel.photo ?? "")
        UserDefaults.standard.set(userId: userModel.uid ?? "")
        UserDefaults.standard.set( userModel.google_map_key ?? "", forKey: Key.APIParameter.googleMapkey)
        UserDefaults.standard.set(lastName: userModel.lastname ?? "")
        UserDefaults.standard.set(countryCode: userModel.countrycode ?? "")
        UserDefaults.standard.set(userName: userModel.name ?? "")
     }
    
}

// MARK: - Action Handler

extension LoginViewController {
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        //AppDelegate.delegate()?.setRootMenuViewController()

        if isValidInput() {
            self.callSignInAPI()
        }
    
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        loadSignUpScreen()
    }
    
    @IBAction func forgotPasswordButtonTapped(_ sender: Any) {
        loadForgotPasswordScreen()
    }
    
    func loadSignUpScreen() {
        let storyboard = UIStoryboard(name: StoryBoardName.login.rawValue, bundle: Bundle.main)
        let loginController = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        self.navigationController?.pushViewController(loginController!, animated: true)
    }
    
    func loadForgotPasswordScreen() {
        let storyboard = UIStoryboard(name: StoryBoardName.login.rawValue, bundle: Bundle.main)
        let forgotPasswordController = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as? ForgotPasswordViewController
        self.navigationController?.pushViewController(forgotPasswordController!, animated: true)
    }
    
}

// MARK: - WebService

extension LoginViewController {
    
    func callSignInAPI() {
        
        showLoader()
        
        LoginClient.login(loginRouter: LoginRouter.login(email: emailTextField.text!, password: passwordTextField.text!), successCompletion: { (result) in

            print(result)
            if result.status == 404 {
                showAlert(message: result.message?.message ?? "", inViewController: self)
            } else if result.uid != nil {
                self.saveUserData(result.message!)
                AppDelegate.delegate()?.setRootMenuViewController()
            } else {
                showAlert(message: result.message?.message ?? "", inViewController: self)
            }
            dismissLoader()
            
        }, failureCompletion: { (error) in
            print(error)
            dismissLoader()
        })
    }
}
