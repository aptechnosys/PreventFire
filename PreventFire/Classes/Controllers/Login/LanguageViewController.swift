//
//  LanguageViewController.swift
//  PreventFire
//
//  Created by Shantaram Kokate on 1/31/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//
//com.preventfire
import UIKit

class LanguageViewController: AbstractViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tickButton: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var menuTableView: UITableView!
    
    let languageList = ["English", "Hindi"]
    var isLanguageViewAfterLogin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isLanguageViewAfterLogin {
            showNavigationBar()
        } else {
            hideNavigationBar()
        }
        NotificationInteractors.shared.registerForPushNotification()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tickButtonTapped(_ sender: Any) {
        if isLanguageViewAfterLogin {
            
        } else if UserDefaults.standard.getLanguage() != nil {
            loadLoginScreen()
        }
    }
    
    func loadLoginScreen() {
        let storyboard = UIStoryboard(name: StoryBoardName.login.rawValue, bundle: Bundle.main)
        let loginController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        self.navigationController?.pushViewController(loginController!, animated: true)
    }
    
    private func setupNavigationBarRightButton() {
       /* let button: UIButton = UIButton.init(type: .custom)
        button.setImage(#imageLiteral(resourceName: "tick"), for: .normal)
        button.isUserInteractionEnabled = true
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.addTarget(self, action: #selector(tickButtonTapped(_:)), for: .touchUpInside)
        let leftButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = leftButton */
    }
    
    
}

// MARK: - Configure UI

extension LanguageViewController {
    
    private func configureUI() {
        setupUIComponents()
    }
    
    private func setupUIComponents() {
        setupLabels()
        setupTableView()
        if isLanguageViewAfterLogin {
            setupNavigationBar()
            //setupNavigationBarRightButton()
           // self.tickButton.isHidden = true
        } else {
            hideNavigationBar()
          //  self.tickButton.isHidden = false
        }
    }
    
    private func setupNavigationBar() {
        
            if isFromMenuView {
                addLeftMenuItem()
                setTransparentNavigationBar()
                setNavigationBarTitle(LocalizedStrings.chooseLanguage)
                configureNavbarTitle(LocalizedStrings.chooseLanguage)
                
            } else {
                setTransparentNavigationBar()
                setNavBarTitle(LocalizedStrings.chooseLanguage)
                addbackButton()
            }
        
        
        //addLeftMenuItem()
       // setTransparentNavigationBar()
       // setNavigationBarTitle(LocalizedStrings.chooseLanguage)
        
    }
    
    private func setupLabels() {
        self.titleLabel.configureLabel(title: LocalizedStrings.fireSafeIndiaFoundation, color: AppColor.Label.logoTitle, font: FontStyle(family: .poppins, type: .medium, size: .pt17), alignment: .center)

    }
    
    private func setupTableView() {
        menuTableView.backgroundColor = .clear
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.isScrollEnabled = false
        menuTableView.register(UINib(nibName: "LanguageCell", bundle: nil), forCellReuseIdentifier: CellIdentifier.languageCell)
    }
}

// MARK: - UITable DataSource

extension LanguageViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: LanguageCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.languageCell, for: indexPath as IndexPath) as? LanguageCell else {
            fatalError()
        }
        cell.setData(languageList[indexPath.row])
        if UserDefaults.standard.getLanguage() == languageList[indexPath.row] {
            cell.languageButton.backgroundColor = .green
        }
        return cell
    }
    
}

// MARK: - UITable Delegate

extension LanguageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(language: languageList[indexPath.row])
        if isLanguageViewAfterLogin {
        } else if UserDefaults.standard.getLanguage() != nil {
            loadLoginScreen()
        }
    }
}
