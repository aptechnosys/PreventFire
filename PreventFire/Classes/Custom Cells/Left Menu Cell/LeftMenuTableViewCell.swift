import UIKit

class LeftMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.backgroundColor = AppColor.Table.selectedColor
        } else {
            self.backgroundColor = .clear
        }
        // Configure the view for the selected state
    }
}

extension LeftMenuTableViewCell {
    func configureUI() {
        initializeLabels()
    }
    
    func initializeLabels() {
        titleLabel.configureLabel(title: "", color: .white, font: FontStyle(family: .poppins, type: .regular, size: .pt14), alignment: .left)
    }
    
    func setData(_ menuOption: MenuOptions) {
        titleLabel.text = menuOption.title
        iconImageView.image = menuOption.icon
    }
    
}
