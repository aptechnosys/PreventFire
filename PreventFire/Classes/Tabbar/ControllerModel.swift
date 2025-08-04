//
//  ControllerModel.swift
//  HomeServices
//
// on 9/12/18.

//

import Foundation
import UIKit

enum Page: String {
    //case newsFeeds = "News Feeds"
    case magazine = "Magazine"
    case dashborad = "Dashborad"
    case complaints = "Complaints"
}
class ControllerModel {
    
    static var shared = ControllerModel()
    
    var vcDictionary: [Page: UIViewController] = {
        var dict = [Page: UIViewController]()
        dict[.dashborad] = loadHomeView()
        //dict[.newsFeeds] = loadNewsFeedsView()
        dict[.magazine] = loadMagazineScreen()
        dict[.complaints] = loadAllComplaintsView()
        return dict
    }()

    var viewControllers: [UIViewController] {
        return orderedPages.map({ (title) -> UIViewController in
             return vcDictionary[title]!
        })
    }
    
    var normalTabBarImages: [String] {
        return ["icon_dashboard", "magazine_tab", "news_feeds_tab", "icon_fire_safety"]
    }
    
    var selectedTabBarImages: [String] {
        return ["news_feeds_tab", "magazine_tab", "icon_dashboard", "icon_fire_safety"]
    }
    
    //Page order in tab bar
    var orderedPages: [Page] {
       return [.dashborad, .magazine, .complaints]
    }
    //Display name
    var displayName: [String] {
        return orderedPages.map { $0.rawValue }
    }
    
}

func loadMagazineScreen() -> MagazineListViewController {
    let storyboard = UIStoryboard(name: StoryBoardName.magazine.rawValue, bundle: Bundle.main)
    let loginController = storyboard.instantiateViewController(withIdentifier: "MagazineListViewController") as? MagazineListViewController
    loginController?.isFromMenuView = true
    return loginController!
 }

func loadHomeView()  -> HomeViewController {


    let storyboard = UIStoryboard(name: StoryBoardName.home.rawValue, bundle: Bundle.main)
    let loginController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController

    return loginController!
}

func loadAllComplaintsView() -> AllComplaintsViewController {

    let storyborad = UIStoryboard(name: StoryBoardName.serviceDetail.rawValue, bundle: nil)
    let alertViewController = storyborad.instantiateViewController(withIdentifier: "AllComplaintsViewController") as? AllComplaintsViewController
    alertViewController?.isFromMenuView = true
    return alertViewController!

}

func loadNewsFeedsView() -> NewsFeedsViewController {

    let storyborad = UIStoryboard(name: StoryBoardName.magazine.rawValue, bundle: nil)
    let alertViewController = storyborad.instantiateViewController(withIdentifier: "NewsFeedsViewController") as? NewsFeedsViewController
    alertViewController?.isFromMenuView = true
    return alertViewController!

}

