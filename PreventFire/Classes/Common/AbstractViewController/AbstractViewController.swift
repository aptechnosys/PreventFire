//
//  AbstractViewController.swift
//  PreventFire
//
//  Created by Shantaram Kokate on 1/31/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit

class AbstractViewController: UIViewController {
    
    var isFromMenuView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addbackButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addbackButton() {
        self.configureNavbarLeftButton(imageName: "arrow-blk-filled-40")
    }
    
    func setTransparentNavigationBar() {
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = self.imageWithColor(color: .clear)
        self.navigationController?.navigationBar.isTranslucent = true 
  
    }
    
    func configureNavbarLeftButton(imageName: String) {
        let button: UIButton = UIButton.init(type: .custom)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.isUserInteractionEnabled = true
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 40)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -7, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(backButtonClicked(sender:)), for: .touchUpInside)
        let leftButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = leftButton
        let spacer = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
        spacer.isEnabled = false
        spacer.tintColor = UIColor.clear
        self.navigationItem.rightBarButtonItem = spacer
    }
    
    func imageWithColor(color: UIColor) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        return image
    }
    
    func applyNavigatinBarColor() {
        self.applyNavigationBarUICustomization(barColor: AppColor.primaryColor, titleColor: .clear)
        self.navigationController?.navigationItem.title = ""
    }
    
    @objc func backButtonClicked(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
  
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
// MARK: - Alert View delegate

extension AbstractViewController: AlertViewDelegate {
    func alertView(alertView: AlertView, clickedButtonAtIndex buttonIndex: Int) {
    }
}
// MARK: - Navigation

extension AbstractViewController {
    
    func applyNavigationBarUICustomization(barColor: UIColor, titleColor: UIColor) {
        self.navigationController?.navigationBar.barTintColor = barColor
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor, NSAttributedString.Key.font: UIFont.poppins(font: .medium, size: .pt17)]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationController?.navigationBar.barTintColor = barColor
    }
    
    func setNavBarTitle(_ titleText: String) {
        
        configureNavbarLeftButton(imageName: "arrow-blk-filled-40")
        configureNavbarTitle(titleText)
    }
    
    func setNavigationLeftBarTitle(_ titleText: String) {
        let leftView: UIView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 150, height: 40)
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 40)
        titleLabel.text = titleText.localized()
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.poppins(font: .medium, size: .pt17)
        leftView.addSubview(titleLabel)
        let leftButton = UIBarButtonItem(customView: leftView)
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationItem.title = ""
    }
    
    func applyThemeNavBar() {
        self.applyNavigationBarUICustomization(barColor: UIColor.themeColor, titleColor: .clear)
    }
    
    func configureNavbarTitle(_ titleText: String) {
        let size: CGRect = UIScreen.main.bounds
        let lbNavTitle: UILabel = UILabel.init(frame: CGRect(x: 40, y: 30, width: size.width - 100, height: 40))
        lbNavTitle.textAlignment = .left
       // lbNavTitle.backgroundColor = .red
        lbNavTitle.text = titleText.localized()
        lbNavTitle.textColor = .white
        lbNavTitle.font = UIFont.poppins(font: .medium, size: .pt17)
        self.navigationItem.titleView = lbNavTitle
        
    }
    
    func configureNavbarTitle(_ titleText: String, titleColor: UIColor) {
        let size: CGRect = UIScreen.main.bounds
        let lbNavTitle: UILabel = UILabel.init(frame: CGRect(x: 40, y: 30, width: size.width - 100, height: 40))
        lbNavTitle.textAlignment = .left
        // lbNavTitle.backgroundColor = .red
        lbNavTitle.text = titleText.localized()
        lbNavTitle.textColor = titleColor
        lbNavTitle.font = UIFont.poppins(font: .medium, size: .pt17)
        self.navigationItem.titleView = lbNavTitle
        
    }
    
    
}
