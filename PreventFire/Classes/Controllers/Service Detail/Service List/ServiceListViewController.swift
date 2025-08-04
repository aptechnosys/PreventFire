//
//  ServiceListViewController.swift
//  PreventFire
//
//  Created by Shantaram Kokate on 2/7/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit
import ESPullToRefresh
import SDWebImage

enum TabStatus: Int {
    case resolved
    case unResolved
}


class ServiceListViewController: AbstractViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var resolvedButton: UIButton!
    @IBOutlet weak var unResolvedButton: UIButton!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var resolvedLabel: UILabel!
    @IBOutlet weak var unRresolvedLabel: UILabel!

    // MARK: - Properties
    
    var activeServiceList = [String]()
    var pageOffset = 0
    var pageLimit = "10"
    
    var resovledList = [Resolved]()
    var unResovledList = [Resolved]()

    var menuList = [Concern]()
    
      var tabStatus: TabStatus = .resolved {
        didSet {
            if tabStatus == .resolved {
                self.resolvedLabel.isHidden = false
                self.unRresolvedLabel.isHidden = true
                resolvedButton.titleLabel?.font = UIFont.poppins(font: .medium, size: .pt14)
                unResolvedButton.titleLabel?.font = UIFont.poppins(font: .regular, size: .pt14)

            } else {
                self.resolvedLabel.isHidden = true
                self.unRresolvedLabel.isHidden = false
                resolvedButton.titleLabel?.font = UIFont.poppins(font: .regular, size: .pt14)
                unResolvedButton.titleLabel?.font = UIFont.poppins(font: .medium, size: .pt14)
            }
            self.listTableView.reloadData()
        }
    }
    
    // MARK: - View life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchConsentList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
        setNavigationBarTitle(LocalizedStrings.myComplaints)
        configureNavbarTitle(LocalizedStrings.myComplaints)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    
    func setupNavigationBar() {
        setupNavigationBarRightButton()
        if isFromMenuView {
            addLeftMenuItem()
            setTransparentNavigationBar()
            setNavigationBarTitle(LocalizedStrings.myComplaints)
            configureNavbarTitle(LocalizedStrings.myComplaints)
            
        } else {
            setTransparentNavigationBar()
            setNavBarTitle(LocalizedStrings.myComplaints)
            addbackButton()
        }
    }
  
    
}

// MARK: - Configure UI

extension ServiceListViewController {
    
    func configureUI() {
        setupUI()
        addNotificationObserver()
        applyNavigatinBarColor()
        setupTableView()
        setupNavigationBar()
        setupSwpeGesture()
        setupButton()
        setupLabel()
        
    }
    
    fileprivate func setupUI() {
        listTableView.estimatedRowHeight = UnResolvedComplaintCell.cellHeight
        listTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupLabel()  {
        self.unRresolvedLabel.backgroundColor = .orange
        self.resolvedLabel.backgroundColor = .orange
    }
    
    private func setupButton() {
        resolvedButton.configureButtonWithTitle(title: LocalizedStrings.resolved.uppercased(), titleColor: .black, backgroundColor: .white, font: FontStyle(family: .poppins, type: .medium, size: .pt14))
        unResolvedButton.configureButtonWithTitle(title: LocalizedStrings.unresolved.uppercased(), titleColor: .black, backgroundColor: .white, font: FontStyle(family: .poppins, type: .regular, size: .pt14))
    }
    
    private func setupTableView() {
        listTableView.backgroundColor = .clear
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(UINib(nibName: "UnResolvedComplaintCell", bundle: nil), forCellReuseIdentifier: CellIdentifier.unResolvedComplaintCell)
        listTableView.backgroundView = UIImageView(image: UIImage(named: "background"))
        
    }
    
    
    private func addNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadView), name: .reloadCompletedView, object: nil)
        
    }
    
    @objc func reloadView(notifcation: NSNotification) {
        
        if !NetworkPreferences.isInternetConnectionAvailable() {
            showAlert(message: AlertMessage.noInternet, inViewController: self)
            return
        }
        pageOffset = 0
        self.viewWillAppear(true)
        self.listTableView.reloadData()
    }
    
    private func setupNavigationBarRightButton() {
        let button: UIButton = UIButton.init(type: .custom)
        button.setImage(#imageLiteral(resourceName: "add_icon"), for: .normal)
        button.isUserInteractionEnabled = true
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        let leftButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = leftButton
    }
}

// MARK: - Action

extension ServiceListViewController {
    
    @IBAction func tabBarButtonTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            tabStatus = .resolved
        } else if sender.tag == 1 {
            tabStatus = .unResolved
        }
        self.listTableView.reloadData()
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        loadConcernRequestScreen()
    }
    
    func loadConcernRequestScreen() {
        let storyboard = UIStoryboard(name: StoryBoardName.serviceRequest.rawValue, bundle: Bundle.main)
        let concernRequestViewController = storyboard.instantiateViewController(withIdentifier: "ConcernRequestViewController") as? ConcernRequestViewController
        concernRequestViewController?.isFromMenuView = false
        self.navigationController?.pushViewController(concernRequestViewController!, animated: true)
    }
    private func setupSwpeGesture() {
        addSwipe(directions: [.right, .left])
    }
    
    func addSwipe(directions: [UISwipeGestureRecognizer.Direction] ) {
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(ServiceListViewController.respondToSwipeGesture(gesture:)))
            gesture.direction = direction
            self.view.addGestureRecognizer(gesture)
        }
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                print("Swiped right")
                tabStatus = .resolved
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
            case UISwipeGestureRecognizer.Direction.left:
                print("Swiped left")
                tabStatus = .unResolved
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
            default:
                break
            }
            self.listTableView.reloadData()
        }
    }
    
}
// MARK: - UITable DataSource

extension ServiceListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tabStatus == .resolved) ? resovledList.count : unResovledList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: UnResolvedComplaintCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.unResolvedComplaintCell, for: indexPath as IndexPath) as? UnResolvedComplaintCell else {
            fatalError()
        }
        let consent  = (tabStatus == .resolved) ? resovledList[indexPath.row] : unResovledList[indexPath.row]
        cell.setData(consent: consent)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UnResolvedComplaintCell.cellHeight
    }
}

// MARK: - UITable Delegate

extension ServiceListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let concern  = (tabStatus == .resolved) ? resovledList[indexPath.row] : unResovledList[indexPath.row]
       setServiceDetailView(concern: concern)
    }
}

// MARK: - Methods

extension ServiceListViewController {
    
    private func fetchConsentList() {
        callServiceRequestListAPI { (allConcernModelBase, error) in
            if !error {
                self.mapConsentList(allConcernModelBase!)
                self.listTableView.reloadData()
            }
        }
    }
    
    private func mapConsentList(_ allConcernModelBase: AllConcernModelBase) {
        let status = allConcernModelBase.status
        if status == 200 {
            self.resovledList = allConcernModelBase.resolved ?? []
            self.unResovledList = allConcernModelBase.unresolved ?? []
        }
    }
}
// MARK: - WebServices

extension ServiceListViewController {
    
    func callServiceRequestListAPI(completionHandler: @escaping(AllConcernModelBase?, Bool) -> Void) {
        
        if !NetworkPreferences.isInternetConnectionAvailable() {
            showAlert(message: AlertMessage.noInternet, inViewController: self)
            return
        }
        showLoader()
        let userId = SessionData.userId
        ServiceRequestClient.allServiceRequestList(serviceRequestRouter: ServiceRequestRouter.requestList(userId: userId),
                                                   successCompletion: { (result) in
                                                    completionHandler(result, false)
                                                    dismissLoader()
        }, failureCompletion: { (error) in
            dismissLoader()
            if let errorDetail  = error.general?[0] {
                showAlert(message: errorDetail.message!, inViewController: self)
            }
            completionHandler(nil, true)
        })
    }
}

extension ServiceListViewController {
    
    func setServiceDetailView(concern: Resolved) {
        let storyborad = UIStoryboard(name: StoryBoardName.serviceDetail.rawValue, bundle: nil)
        let serviceDetailViewController = storyborad.instantiateViewController(withIdentifier: "ServiceDetailViewController") as? ServiceDetailViewController
        serviceDetailViewController!.concern = concern
        self.navigationController?.pushViewController(serviceDetailViewController!, animated: true)
    }
}

// MARK: - PullToRefresh

extension ServiceListViewController {
    
    func setUpPullToRefresh() {
        let header = self.listTableView.es.addInfiniteScrolling {
            [unowned self] in
            self.loadMore()
        }
        if let animator = header.animator as? ESRefreshFooterAnimator {
            animator.refreshAnimationEnd(view: header)
        }
    }
    
    private func loadMore() {
    }
}

