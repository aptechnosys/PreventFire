import UIKit

class NewsFeedsCell: UITableViewCell {
    
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

extension NewsFeedsCell {
    func configureUI() {
        initializeLabels()
    }
    
    func initializeLabels() {
        let des = "Mr McConnell said regardless of who wins the 3 November presidential election, there will be a peaceful inauguration on 20 January."
        let title = "McConnell promises an 'orderly' transition of power"
        
        titleLabel.configureLabel(title: title, color: .black, font: FontStyle(family: .poppins, type: .semiBold, size: .pt14), alignment: .left)
        descriptionLabel.configureLabel(title: des, color: .black, font: FontStyle(family: .poppins, type: .regular, size: .pt14), alignment: .left)

    }
    
    func setData(_ menuOption: MenuOptions) {
        titleLabel.text = menuOption.title
        iconImageView.image = menuOption.icon
    }
    
}
