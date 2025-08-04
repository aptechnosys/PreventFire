//
//  ServiceDetailViewController.swift
//  PreventFire
//
//  Created by Shantaram Kokate on 2/1/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit

class ServiceDetailViewController: AbstractViewController {
    
    // MARK: - @IBOutlet
    
    @IBOutlet weak var mapImgaeView: UIImageView!
    @IBOutlet weak var affectPeopleLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var affectedButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var issueDescriptionLabel: UILabel!
    @IBOutlet weak var contactDetailHeaderLabel: UILabel!
    @IBOutlet weak var userEmailAddressLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    // MARK: - Properties

    var concern : Resolved?
    
    var concernItem : Concern?

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureUI()
        setData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var fullAddress: String {
        let buildingName = concern?.bldgname ?? ""
        let address = concern?.address ?? ""
        return buildingName + "\n" + address
    }
    
    func setData() {
        if concern != nil {
            let url = URL(string: concern?.mapimage ?? "")
            self.mapImgaeView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"), options: .refreshCached, completed: nil)
            let profileurl = URL(string: concern?.photo ?? "")
            self.userImageView.sd_setImage(with: profileurl, placeholderImage: #imageLiteral(resourceName: "placeholder-profile-picture-icon-1"), options: .refreshCached, completed: nil)
            let affectedCount = concern?.peopleaffected ?? ""
            affectPeopleLabel.text = "Affected Person " + affectedCount
            categoryNameLabel.text = concern?.enquiryName ?? ""
            // userNameLabel.text = concern.us ?? ""
            issueDescriptionLabel.text =  concern?.message ?? ""
            userEmailAddressLabel.text =  UserDefaults.standard.getEmailNumber() ?? ""
            userNameLabel.text =  UserDefaults.standard.getUserName() ?? ""
            addressLabel.text =  fullAddress
        } else {
            let url = URL(string: concernItem?.mapimage ?? "")
            self.mapImgaeView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"), options: .refreshCached, completed: nil)
            let profileurl = URL(string: concernItem?.photo ?? "")
            self.userImageView.sd_setImage(with: profileurl, placeholderImage: #imageLiteral(resourceName: "placeholder-profile-picture-icon-1"), options: .refreshCached, completed: nil)
            let affectedCount = concernItem?.peopleaffected ?? ""
            affectPeopleLabel.text = "Affected Person " + affectedCount
            categoryNameLabel.text = concernItem?.enquiryName ?? ""
            issueDescriptionLabel.text =  concernItem?.message ?? ""
            userEmailAddressLabel.text =  UserDefaults.standard.getEmailNumber() ?? ""
            userNameLabel.text =  UserDefaults.standard.getUserName() ?? ""
            addressLabel.text =  fullAddress
        }
    }
    
}


// MARK: - Configure UI

extension ServiceDetailViewController {
    
    private func configureUI() {
        setupUIComponents()
    }
    
    private func setupUIComponents() {
        setupButtons()
        setupLabels()
        setupNavigationBar()
    }
    
    private func setupLabels() {
        self.affectPeopleLabel.configureLabel(color: AppColor.Label.affectPersonBackground!, font: FontStyle(family: .poppins, type: .medium, size: .pt16), alignment: .left)
        self.addressLabel.configureLabel(color: .gray, font: FontStyle(family: .poppins, type: .regular, size: .pt16), alignment: .left)
        self.contactDetailHeaderLabel.configureLabel(color: .black, font: FontStyle(family: .poppins, type: .regular, size: .pt14), alignment: .left)
        self.contactDetailHeaderLabel.backgroundColor = .gray
        self.userNameLabel.configureLabel(color: .gray, font: FontStyle(family: .poppins, type: .regular, size: .pt16), alignment: .left)
        self.userEmailAddressLabel.configureLabel(color: .gray, font: FontStyle(family: .poppins, type: .regular, size: .pt16), alignment: .left)
        self.addressLabel.configureLabel(color: .gray, font: FontStyle(family: .poppins, type: .regular, size: .pt16), alignment: .left)
        
        self.issueDescriptionLabel.configureLabel(color: .gray, font: FontStyle(family: .poppins, type: .regular, size: .pt16), alignment: .left)
        
    }
    
    private func setupButtons() {
        affectedButton.configureButtonWithTitle(title: "I'm Affected", titleColor: .white, backgroundColor: AppColor.Button.affectedBackgroundColor!, font: FontStyle(family: .poppins, type: .medium, size: .pt14))
        
    }
    
    private func setupNavigationBar() {
        setTransparentNavigationBar()
        addbackButton()
        self.setNavigationBarTintColor()
        configureNavbarTitle(LocalizedStrings.complaintDetails, titleColor: .black)
        configureNavbarLeftButton(imageName: "back_black")
    }
    
    // MARK: - Action Handler
    
    func setNavigationBarTintColor() {
        let bar: UINavigationBar! =  self.navigationController?.navigationBar
        bar.tintColor = .black
        self.navigationController?.navigationBar.isHidden = false
    }
    
}

// MARK: - Configure UI

extension ServiceDetailViewController {
    @IBAction func shareButtonClick(_ sender: Any) {
        shareApp()
    }
    
    func shareApp() {
      //  let text = issueDescriptionLabel.text ?? ""
        let text = (concern != nil) ? concern?.sharelink! : concernItem?.sharelink!
        let subject = LocalizedStrings.shareOnMediaSubject
        let textToShare = [text]
        let activityViewController = UIActivityViewController.init(activityItems: textToShare, applicationActivities: nil)
        activityViewController.setValue(subject, forKey: "subject")
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}
