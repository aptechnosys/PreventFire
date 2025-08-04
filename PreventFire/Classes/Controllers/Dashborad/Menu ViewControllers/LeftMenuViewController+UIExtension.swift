import Foundation
import UIKit

extension LeftMenuViewController {
    
    func configureUI() {
        initializeLabels()
        initializeTableView()
    }
    
    func initializeImageView() {
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.image = #imageLiteral(resourceName: "placeholder-profile-picture-icon-1")
    }
    
    func initializeLabels() {
        let firstName = UserDefaults.standard.getUserName() ?? ""
        let lastName = UserDefaults.standard.getLastName() ?? ""
        nameLabel.configureLabel(title: firstName + " " + lastName, color: .white, font: FontStyle(family: .poppins, type: .light, size: .pt14), alignment: .center)
        let countryCode = UserDefaults.standard.getcountryCode() ?? "91"
        let mobileNumber = UserDefaults.standard.getMobileNumber() ?? ""
        var mobileWithCountryCode = ""
        if countryCode.isEmpty {
            mobileWithCountryCode = "+91 " + mobileNumber
        } else {
            mobileWithCountryCode = "+" + countryCode + " " + mobileNumber
        }
        
        contactNumberLabel.configureLabel(title: mobileWithCountryCode, color: .white, font: FontStyle(family: .poppins, type: .light, size: .pt14), alignment: .center)
        let url = URL(string: UserDefaults.standard.getImageUrl() ?? "")
        self.profileImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "addUser"), options: .refreshCached, completed: nil)
        
    }
    
    func initializeTableView() {
        self.menuTableView.register(UINib(nibName: "LeftMenuTableViewCell", bundle: nil), forCellReuseIdentifier: CellIdentifier.leftMenuCell)
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        self.menuTableView.backgroundColor = UIColor.clear
        self.menuTableView.separatorColor = UIColor.clear
        self.menuTableView.separatorStyle = .none
        self.menuTableView.estimatedRowHeight = 60
        self.menuTableView.reloadData()
        
    }
}

// MARK: - UITableView Delegate And Datasource Methods

extension LeftMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: CellIdentifier.leftMenuCell) as? LeftMenuTableViewCell)!
        
        cell.setData(viewModel.menuOptions[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menu = viewModel.menuOptions[indexPath.row]
        menuOptionSelected(menu)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
}

private extension LeftMenuViewController {
    
    func menuOptionSelected(_ menu: MenuOptions) {
        
        switch menu {
            
        case .dashboard:
            loadDashboardScreen()
        case .fireSafetyConcerns:
            pushtoAllComplaintsView()
        case .previousConcerns:
            pushtoComplaintsView()
        case .raiseYourVoiceForFire:
            loadConcernRequestScreen()
        case .alerts:
            pushtoAlertView()
        case .profile:
            loadProfileScreen()
        case .languageSetting:
            loadLanguageScreen()
        case .signout:
            confirmAccountLogout()
        }
    }
}
