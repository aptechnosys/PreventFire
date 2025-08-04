import UIKit

class LeftMenuViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var menuTableView: UITableView!
    
    @IBOutlet weak var contactNumberLabel: UILabel!
    
    let viewModel = MenuViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureUI()
    }
    
    // MARK: - Events
    
    func pushtoComplaintsView() {
        /*let  complaintsBaseViewController = ComplaintsBaseViewController()
        complaintsBaseViewController.isFromMenuView = true

        let navigation = UINavigationController(rootViewController: complaintsBaseViewController)
        self.slideMenuController()?.changeMainViewController(navigation, close: true) */
        
        let storyborad = UIStoryboard(name: StoryBoardName.serviceDetail.rawValue, bundle: nil)
        let serviceListViewController = storyborad.instantiateViewController(withIdentifier: "ServiceListViewController") as? ServiceListViewController
        serviceListViewController?.isFromMenuView = true
        
        let navigationController = UINavigationController(rootViewController: serviceListViewController!)
        self.slideMenuController()?.changeMainViewController(navigationController, close: true)
        

    }
    
    func pushtoAlertView() {
        
        let storyborad = UIStoryboard(name: StoryBoardName.serviceDetail.rawValue, bundle: nil)
        let alertViewController = storyborad.instantiateViewController(withIdentifier: "AlertViewController") as? AlertViewController
        alertViewController?.isFromMenuView = true

        let navigationController = UINavigationController(rootViewController: alertViewController!)
        self.slideMenuController()?.changeMainViewController(navigationController, close: true)
        
    }
    
    func pushtoAllComplaintsView() {
        
        let storyborad = UIStoryboard(name: StoryBoardName.serviceDetail.rawValue, bundle: nil)
        let alertViewController = storyborad.instantiateViewController(withIdentifier: "AllComplaintsViewController") as? AllComplaintsViewController
        alertViewController?.isFromMenuView = true

        let navigationController = UINavigationController(rootViewController: alertViewController!)
        self.slideMenuController()?.changeMainViewController(navigationController, close: true)
    }
    
    func loadProfileScreen() {
        let storyboard = UIStoryboard(name: StoryBoardName.login.rawValue, bundle: Bundle.main)
        let profileController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
        profileController?.isFromMenuView = true
        self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: profileController!), close: true)
    }
    
    func confirmAccountLogout() {
        let alertView = AlertView(title: AlertMessage.success, message: AlertMessage.logoutMessage, okButtonText: LocalizedStrings.logout, cancelButtonText: AlertMessage.Cancel) { (_, button) in
            if button == .other {
                UserDefaults.standard.clearUser()
                AppDelegate.delegate()?.setLanguageViewController()
            }
        }
        alertView.show(animated: true)
    }
    
    func loadLanguageScreen() {
        let storyboard = UIStoryboard(name: StoryBoardName.login.rawValue, bundle: Bundle.main)
        let languageViewController = storyboard.instantiateViewController(withIdentifier: "LanguageViewController") as? LanguageViewController
        languageViewController?.isLanguageViewAfterLogin = true
        languageViewController?.isFromMenuView = true
        self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: languageViewController!), close: true)
    }
    
    
    func loadDashboardScreen() {

         self.slideMenuController()?.changeMainViewController(HomeTabBarController(), close: true)

        //AppDelegate.delegate()?.setRootMenuViewController()
    }

    func loadConcernRequestScreen() {
        let storyboard = UIStoryboard(name: StoryBoardName.serviceRequest.rawValue, bundle: Bundle.main)
        let concernRequestViewController = storyboard.instantiateViewController(withIdentifier: "ConcernRequestViewController") as? ConcernRequestViewController
        concernRequestViewController?.isFromMenuView = true
        self.slideMenuController()?.changeMainViewController(UINavigationController(rootViewController: concernRequestViewController!), close: true)
    }
  
}
