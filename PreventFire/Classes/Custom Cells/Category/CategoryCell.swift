//
//  CategoryCell.swift
//  PreventFire
//
//  Created by Shantaram Kokate on 2/1/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    // MARK: - IBOutlet

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    // MARK: - Properties

    static let cellHeight: CGFloat = 130.0

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
    
    func setData(_ category: Catinfo) {
         self.titleLabel.text = category.catName
        let url = URL(string: category.catFile ?? "")
        self.categoryImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "logo"), options: .refreshCached, completed: nil)
    }
    
}
// MARK: - Configure UI

extension CategoryCell {
    
    private func configureUI() {
        setupUIComponents()
    }
    
    private func setupUIComponents() {
        setupLabels()
    }
    
    private func setupLabels() {
        self.titleLabel.configureLabel(title: "Testing", color: .white, font: FontStyle(family: .poppins, type: .regular, size: .pt16), alignment: .left)
    }
}
