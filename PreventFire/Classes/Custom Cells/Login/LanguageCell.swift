//
//  LanguageCell.swift
//  PreventFire
//
//  Created by Shantaram Kokate on 1/31/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit

class LanguageCell: UITableViewCell {

    @IBOutlet weak var languageButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        if selected {
            self.languageButton.backgroundColor = .green
        } else {
            self.languageButton.backgroundColor = AppColor.primaryColor
        }
    }
    
}

// MARK: - Configure UI

extension LanguageCell {
    
    private func configureUI() {
        setupUIComponents()
    }
    
    private func setupUIComponents() {
        setupButtons()
    }

    private func setupButtons() {
        languageButton.isUserInteractionEnabled = false
        languageButton.configureButtonWithTitle(title: "", titleColor: .white, backgroundColor: AppColor.primaryColor, font: FontStyle(family: .poppins, type: .regular, size: .pt16))
    }
    
    func setData(_ language: String) {
        if UserDefaults.standard.getLanguage() == language {
            self.isSelected = true
            self.languageButton.backgroundColor = .green
        } else {
            self.isSelected = false
            self.languageButton.backgroundColor = AppColor.primaryColor
        }
        languageButton.setTitle(language, for: .normal)
    }
}
