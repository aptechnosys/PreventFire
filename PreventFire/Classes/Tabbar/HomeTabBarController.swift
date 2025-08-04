//
//  HomeTabBarController.swift
//  HomeServices
//
// on 8/16/18.


import UIKit
class HomeTabBarController: UITabBarController {
    
    // MARK: - Properties
    
    var tabBarItemBgViews: [UIView] = []
    
    var touchTabIndex = 0
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        self.tabBar.isHidden = true // Hide
        super.viewDidLoad()
       configureTabBar()

    }
}

 // MARK: - TabBarController

extension HomeTabBarController {
    
    func configureTabBar() {
        setupTabbar()
        addChildViewControllers()
        self.delegate = self
    }
    
    func setupTabbar() {
        tabBar.tintColor = AppColor.Tabbar.selectedTextColor
        tabBar.unselectedItemTintColor = AppColor.Tabbar.normalTextColor
        tabBar.barTintColor = UIColor.white
        tabBar.frame.size.height = 0
        setTabbarShadowEffect()
    }
    
    private func addChildViewControllers() {
        addChildViewController(childControllerName: "MagazineListViewController",
                               title: LocalizedStrings.dashboard,
                               imageName: "home",
                               tagValue: 0)
        addChildViewController(childControllerName: "MagazineListViewController",
                               title: LocalizedStrings.magazine,
                               imageName: "projects",
                               tagValue: 1)
//        addChildViewController(childControllerName: "MagazineListViewController",
//                               title: LocalizedStrings.newsFeeds,
//                               imageName: "notifications",
//                               tagValue: 2)
        addChildViewController(childControllerName: "MagazineListViewController",
                               title: LocalizedStrings.complaints,
                               imageName: "profile",
                               tagValue: 2)
    }
 
    private func addChildViewController(childControllerName: String, title: String, imageName: String, tagValue: Int) {

        let viewController: UIViewController = ControllerModel.shared.viewControllers[tagValue]

        viewController.title = title
        viewController.tabBarItem.tag = tagValue
        let image  =  UIImage(named: ControllerModel.shared.selectedTabBarImages[tagValue])
        viewController.tabBarItem.selectedImage = image
        viewController.tabBarItem.image = image
        viewController.tabBarItem.title = title
        let attributes = [
            NSAttributedString.Key.font: UIFont.poppins(font: .regular, size: .pt9)
        ]

        viewController.tabBarItem.setTitleTextAttributes(attributes, for: .normal)
        let nav = UINavigationController.init(rootViewController: viewController)
        
        addChild(nav)
    }
}

// MARK: - TabBarController delegate

extension HomeTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

    }
}

// MARK: - Private method

extension HomeTabBarController {
    
    func setTabbarShadowEffect() {
        tabBar.dropShadow(color: .black, opacity: 0.1, offSet: CGSize(width: 0, height: -4), radius: 4.0, scale: true)
    }
  

    func setBadgeValue(_ value: String, forTabBar: Int) {
        if let tabItems = self.tabBarController?.tabBar.items {
            let tabItem = tabItems[forTabBar]
            tabItem.badgeValue = value
        }
    }
    
}
