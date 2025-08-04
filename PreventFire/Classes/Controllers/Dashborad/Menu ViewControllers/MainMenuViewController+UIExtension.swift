import Foundation
import UIKit
//import SlideMenuControllerSwift

extension MainMenuViewController {
    
    func configureUI() {
        SlideMenuOptions.hideStatusBar = false
        SlideMenuOptions.panFromBezel = false
        SlideMenuOptions.panGesturesEnabled = false
    }
}

extension UIViewController {

    func addLeftMenuItem() {
        let menuIcon = #imageLiteral(resourceName: "menu")
        self.addLeftBarButtonWithImage(menuIcon)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.addLeftGestures()
    }
    
    func addRightMenuItemForFeedsViewController() {
        let bookMarkLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        let bookMarkIcon = UIImage.imageWithLabel(label: bookMarkLabel)
        self.addRightBarButtonWithImage(bookMarkIcon)
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addRightGestures()
    }
    
    func setNavigationBarTitle(_ titleText: String) {
        let bar: UINavigationBar! =  self.navigationController?.navigationBar
        //        bar.barTintColor = UIColor.init(hexString: ColorConstant.navBarTextColor, alpha: 0.6)!
      //  bar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(hexString: ColorConstant.navBarTextColor, alpha: 1.0)!, NSAttributedString.Key.font: UIFont.init(name: FontConstant.elMessiriBold, size: 18.0)!]
        self.title = titleText
        bar.tintColor = .black
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func addLeftNavigationBarButtonWithImage() {
        let leftNavigationBarItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back_btn"),
                                                     style: .plain,
                                                     target: self,
                                                     action: #selector(leftNavigationBarButtonClicked(_:)))
        
        self.navigationItem.leftBarButtonItem = leftNavigationBarItem
    }
    
    func removeLeftNavigationBarButtonWithImage() {
        self.navigationItem.leftBarButtonItems = []
        hideNavigationBackButton()
    }
    
    func hideNavigationBackButton() {
        self.navigationItem.hidesBackButton = true
    }
    
    func showNavigationBackButton() {
        self.navigationItem.hidesBackButton = false
    }
    
    func hideNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }

    func showNavigationBar() {
        self.navigationController?.navigationBar.isHidden = false
    }

    @objc func leftNavigationBarButtonClicked(_ sender: AnyObject) {
        /* do something with left navigation button action */
        self.navigationController?.popViewController(animated: true)
    }
}

extension UIImage {
    class func imageWithLabel(label: UILabel) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0.0)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
