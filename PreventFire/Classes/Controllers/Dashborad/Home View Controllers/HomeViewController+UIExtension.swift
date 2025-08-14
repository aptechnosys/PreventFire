import Foundation

extension HomeViewController {
    
    // MARK: - UI Configuration Methods
  
     func configureUI() {
        //setupView()
        //setupLabels()
        initializeNavigationBar()
        
    }
    
    func initializeNavigationBar() {
        addLeftMenuItem()
        setTransparentNavigationBar()
        setNavigationBarTitle(LocalizedStrings.dashboard_home)
        
    }
    
    private func setupLabels() {
        self.logoTitleLabel.configureLabel(title: LocalizedStrings.fireSafeIndiaFoundation, color: AppColor.Label.logoTitle, font: FontStyle(family: .poppins, type: .medium, size: .pt16), alignment: .center)
        self.raiseVoiceLabel.configureLabel(title: LocalizedStrings.raiseYourVoiceForFireSafety, color: .white, font: FontStyle(family: .poppins, type: .bold, size: .pt14), alignment: .center)
    }
    
    func setupView() {
        self.redView.backgroundColor = AppColor.SupportingColor.red
        self.orangeView.backgroundColor = AppColor.SupportingColor.orange
        self.whiteView.backgroundColor = AppColor.SupportingColor.white
        self.greenView.backgroundColor = AppColor.SupportingColor.green
    }
    
}
