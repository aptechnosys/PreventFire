import UIKit
import UserNotifications

class HomeViewController: AbstractViewController {

    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var orangeView: UIView!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var raiseVoiceLabel: UILabel!
    @IBOutlet weak var logoTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        if let googleKey = UserDefaults.standard.object(forKey: Key.APIParameter.googleMapkey) as? String {
            kGOOGLEMAPKEY = googleKey
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        updateNotificationStatus()
        
    }
    
    // MARK: - Action Handler
    
    private func setupNavigationBar() {
        self.setNavigationBarTintColor()
        configureNavbarTitle(LocalizedStrings.dashboard_home, titleColor: .black)
    }
    
    func setNavigationBarTintColor() {
        let bar: UINavigationBar! =  self.navigationController?.navigationBar
        bar.tintColor = .black
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
}

// MARK: - Action Handler

extension HomeViewController {
    
    @IBAction func concernButtonClick(_ sender: Any) {
        pushtoConcernRequestView()
    }
    
    @IBAction func alertButtonClick(_ sender: Any) {
        pushtoAlertView()
    }
    
    @IBAction func profileButtonClick(_ sender: Any) {
        loadProfileScreen()
    }
    
    @IBAction func allConcernButtonClick(_ sender: Any) {
        pushtoAllComplaintsView()
    }
    
    @IBAction func previousConcernButtonClick(_ sender: Any) {
        pushtoComplaintsView()
    }
}

// MARK: - Private

extension HomeViewController {
    
    func pushtoConcernRequestView() {
        let storyborad = UIStoryboard(name: StoryBoardName.serviceRequest.rawValue, bundle: nil)
        let concernRequestViewController = storyborad.instantiateViewController(withIdentifier: "ConcernRequestViewController") as? ConcernRequestViewController
        concernRequestViewController?.isFromMenuView = false
        self.navigationController?.pushViewController(concernRequestViewController!, animated: false)
    }
    
    func pushtoAlertView() {
        
        let storyborad = UIStoryboard(name: StoryBoardName.serviceDetail.rawValue, bundle: nil)
        let alertViewController = storyborad.instantiateViewController(withIdentifier: "AlertViewController") as? AlertViewController
        alertViewController?.isFromMenuView = false
        self.navigationController?.pushViewController(alertViewController!, animated: false)

    }
    
    // MARK: - Events
    func pushtoComplaintsView() {
        /*let  complaintsBaseViewController = ComplaintsBaseViewController()
        complaintsBaseViewController.isFromMenuView = false
        self.navigationController?.pushViewController(complaintsBaseViewController, animated: false) */

        let storyborad = UIStoryboard(name: StoryBoardName.serviceDetail.rawValue, bundle: nil)
        let serviceListViewController = storyborad.instantiateViewController(withIdentifier: "ServiceListViewController") as? ServiceListViewController
        serviceListViewController?.isFromMenuView = false
        self.navigationController?.pushViewController(serviceListViewController!, animated: false)

    }
    
    func pushtoAllComplaintsView() {
        
        let storyborad = UIStoryboard(name: StoryBoardName.serviceDetail.rawValue, bundle: nil)
        let alertViewController = storyborad.instantiateViewController(withIdentifier: "AllComplaintsViewController") as? AllComplaintsViewController
        alertViewController?.isFromMenuView = false
        self.navigationController?.pushViewController(alertViewController!, animated: false)

    }
    
    func loadProfileScreen() {
        let storyboard = UIStoryboard(name: StoryBoardName.login.rawValue, bundle: Bundle.main)
        let profileController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
        profileController?.isFromMenuView = false
        self.navigationController?.pushViewController(profileController!, animated: false)

    }
    
}

// MARK: - Private Methods

extension HomeViewController: NotificationRequestable {
    
    func updateNotificationStatus() {
        requestNotification { (granted) in
            if granted {
            }
        }
    }
}
