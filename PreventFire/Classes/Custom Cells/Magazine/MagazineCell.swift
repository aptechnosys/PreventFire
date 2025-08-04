import UIKit

class MagazineCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

extension MagazineCell {
    func configureUI() {
        initializeLabels()
    }
    
    func initializeLabels() {

        let des = "A Marie Claire spokeswoman told the BBC that Marie Claire operated in a challenging fashion and beauty sector and that consumers and advertisers have accelerated their move to digital alternatives."
        let title = "Marie Claire"

        titleLabel.configureLabel(title: title, color: .black, font: FontStyle(family: .poppins, type: .semiBold, size: .pt14), alignment: .left)
        descriptionLabel.configureLabel(title: des, color: .black, font: FontStyle(family: .poppins, type: .regular, size: .pt14), alignment: .left)
    }
    
    func setData(_ menuOption: MenuOptions) {
        titleLabel.text = menuOption.title
        iconImageView.image = menuOption.icon
    }
    
}
