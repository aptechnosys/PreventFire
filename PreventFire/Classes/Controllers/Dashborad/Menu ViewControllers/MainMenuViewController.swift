import UIKit
//import SlideMenuControllerSwift

class MainMenuViewController: SlideMenuController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
    }
    
    override func awakeFromNib() {
        /*
        if let controller = UIStoryboard(name: StoryBoardName.home.rawValue, bundle: Bundle.main).instantiateInitialViewController() {
            self.mainViewController = controller
        }
        */
        self.mainViewController = HomeTabBarController()

        let storyborad = UIStoryboard(name: StoryBoardName.menu.rawValue, bundle: nil)
        let homeViewController = storyborad.instantiateViewController(withIdentifier: "LeftMenuViewController")
        self.leftViewController = homeViewController
        /*
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") {
            self.leftViewController = controller
        }*/
        
        super.awakeFromNib()
    }
}
