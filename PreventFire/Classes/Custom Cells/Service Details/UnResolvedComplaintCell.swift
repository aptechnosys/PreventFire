//
//  UnResolvedComplaintCell.swift
//  PreventFire
//
//  Created by Shantaram Kokate on 2/1/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit

class UnResolvedComplaintCell: UITableViewCell {

    // MARK: - IBOutlet

    @IBOutlet weak var serviceImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var buildingNameLabel: UILabel!

    @IBOutlet weak var affectedButton: UIButton!
    @IBOutlet weak var batchImageView: UIImageView!
    @IBOutlet weak var affectedPeopleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    // MARK: - Properties

    static var cellHeight: CGFloat = 143.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(consent: Resolved) {
        let url = URL(string: consent.photo ?? "")
        self.serviceImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"), options: .refreshCached, completed: nil)
        titleLabel.text = consent.enquiryName ?? ""
        addressLabel.text = consent.address ?? ""
        affectedPeopleLabel.text = consent.peopleaffected ?? ""
        buildingNameLabel.text = consent.bldgname ?? ""
    }
  
    func setData(consent: Concern) {
        let url = URL(string: consent.mapimage ?? "")
        self.serviceImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"), options: .refreshCached, completed: nil)
        titleLabel.text = consent.enquiryName ?? ""
        addressLabel.text = consent.address ?? ""
        affectedPeopleLabel.text = consent.peopleaffected ?? ""
        buildingNameLabel.text = consent.bldgname ?? ""
    }
    func setData(consent: AlertConcern) {
        let url = URL(string: consent.mapimage ?? "")
        self.serviceImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"), options: .refreshCached, completed: nil)
        titleLabel.text = consent.enquiryName ?? ""
        addressLabel.text = consent.address ?? ""
        affectedPeopleLabel.text = consent.peopleaffected ?? ""
        buildingNameLabel.text = consent.bldgname ?? ""
    }
}

// MARK: - Configure UI

extension UnResolvedComplaintCell {
    
    private func configureUI() {
        setupUIComponents()
    }
    
    private func setupUIComponents() {
        setupButtons()
        setupLabels()
    }
    
    
    private func setupLabels() {
        self.titleLabel.configureLabel(color: .white, font: FontStyle(family: .poppins, type: .regular, size: .pt16), alignment: .left)
        self.addressLabel.configureLabel(color: .white, font: FontStyle(family: .poppins, type: .regular, size: .pt12), alignment: .left)
        self.buildingNameLabel.configureLabel(color: .white, font: FontStyle(family: .poppins, type: .regular, size: .pt12), alignment: .left)

        self.affectedPeopleLabel.configureLabel(color: AppColor.Label.affectPersonBackground!, font: FontStyle(family: .poppins, type: .medium, size: .pt14), alignment: .right)

    }
    
    private func setupButtons() {
        affectedButton.configureButtonWithTitle(title: "I'm Affected", titleColor: .white, backgroundColor: AppColor.Button.affectedBackgroundColor!, font: FontStyle(family: .poppins, type: .medium, size: .pt14))
        containerView.backgroundColor = AppColor.primaryColor
    }
    
}
