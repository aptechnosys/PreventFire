//
//  ComplaintsBaseViewController.swift
//  PreventFire
//
//  Created by Shantaram Kokate on 2/1/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit

let kStatusBarH: CGFloat = 20
let kNavBarH: CGFloat = 44
let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height
let kTabBarH: CGFloat = 90
let kMenuViewH: CGFloat = 200 //
let kMarginH: CGFloat = 40

private let kTitleViewH: CGFloat = 40

class ComplaintsBaseViewController: AbstractViewController {
    
    var productInfo: NSDictionary! = nil
    var index: Int! = 0
    var resovledList = [Concern]()
    var unResovledList = [Concern]()
    var titles = [String]()
    
    fileprivate lazy var pageTitleView: PageTitleView = {[weak self] in
        
        let titleFrame = CGRect(x: 0, y: 0, width: kScreenW, height: kTitleViewH)
        let titleView = PageTitleView(frame: titleFrame, titles: (self?.titles)!)
        titleView.delegate = self
        titleView.backgroundColor = AppColor.primaryColor
        return titleView
        }()
    
    fileprivate lazy var pageContentView: PageContentView = { [weak self] in
        let contentFrame = CGRect(x: 0, y: kTitleViewH, width: kScreenW, height: kScreenH - kStatusBarH - kNavBarH - kMarginH)
        var childVcs = [UIViewController]()
        
        let storyborad = UIStoryboard(name: StoryBoardName.serviceDetail.rawValue, bundle: nil)
        guard let resolvedComplaintsViewController: ResolvedComplaintsViewController = storyborad.instantiateViewController(withIdentifier: "ResolvedComplaintsViewController") as? ResolvedComplaintsViewController else {
            fatalError()
        }
        
        guard let unResolvedComplaintsViewController: UnResolvedComplaintsViewController = storyborad.instantiateViewController(withIdentifier: "UnResolvedComplaintsViewController") as? UnResolvedComplaintsViewController else {
            fatalError()
        }
        
        childVcs.append((resolvedComplaintsViewController))
        childVcs.append((unResolvedComplaintsViewController))
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        contentView.backgroundColor = .clear
        contentView.delegate = self
        return contentView
        }()
    
    
    let backgroundImageView: UIImageView = {
        let theImageView = UIImageView()
        theImageView.image = #imageLiteral(resourceName: "background")
        theImageView.translatesAutoresizingMaskIntoConstraints = false //You need to call this property so the image is added to your view
        return theImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImgeView()
        titles = [LocalizedStrings.resolved.uppercased(), LocalizedStrings.unresolved.uppercased()]
        setupUI()
        //setNavigationLeftBarTitle(LocalizedStrings.myComplaints)
        //setNavBarTitle(LocalizedStrings.myComplaints)
       // applyNavigatinBarColor()
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        self.automaticallyAdjustsScrollViewInsets = false
        pageContentView.setCurrentIndex(currentIndex: index)
        pageTitleView.currentLabelIndex = index
        if index == 1 {
            pageTitleView.scrollLine.frame.origin.x = kScreenW / 2 + 10
        }
    }
    
    func setupNavigationBar() {
        setupNavigationBarRightButton()
        if isFromMenuView {
            addLeftMenuItem()
            setNavigationBarTitle(LocalizedStrings.myComplaints)
            setTransparentNavigationBar()

        } else {
            setTransparentNavigationBar()
            setNavBarTitle(LocalizedStrings.myComplaints)
            addbackButton()
        }
    }
    
    func addBackgroundImgeView() {
    self.view.addSubview(backgroundImageView)
        self.backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0.0).isActive = true
        if #available(iOS 11.0, *) {
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
        } else {
            // Fallback on earlier versions
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true

        }
        self.backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
        self.backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        self.backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true

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
    
    override func viewWillAppear(_ animated: Bool) {
        //self.applyNavigationBarUICustomization(barColor: .white, titleColor: .clear)
        setTransparentNavigationBar()
        //Check if navigation from Project Tab
        self.navigationController?.navigationBar.backgroundColor = .white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - Action

extension ComplaintsBaseViewController {
    
    @IBAction func addButtonTapped(_ sender: Any) {
        loadConcernRequestScreen()
    }
    
    func loadConcernRequestScreen() {
        let storyboard = UIStoryboard(name: StoryBoardName.serviceRequest.rawValue, bundle: Bundle.main)
        let concernRequestViewController = storyboard.instantiateViewController(withIdentifier: "ConcernRequestViewController") as? ConcernRequestViewController
        concernRequestViewController?.isFromMenuView = false
        self.navigationController?.pushViewController(concernRequestViewController!, animated: true)
    }
}

extension ComplaintsBaseViewController {
    fileprivate func setupUI() {
        //scrollview
        setupNavigationBar()
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
}

// MARK: - PageTitleViewDelegate

extension ComplaintsBaseViewController: PageTitleViewDelegate {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        if self.titles.count >= 2 {
            if index == 1 {
                NotificationCenter.default.post(name: .reloadCompletedView, object: nil, userInfo: nil)
            } else {
                NotificationCenter.default.post(name: .reloadActiveView, object: nil, userInfo: nil)
            }
            pageContentView.setCurrentIndex(currentIndex: index)
        }
    }
}

// MARK: - PageContentViewDelegate

extension ComplaintsBaseViewController: PageContentViewDelegate {
    func pageContentView(_ contentView: PageContentView, didFinished: Bool, targetIndex: Int) {
        if self.titles.count >= 2 {
            if index == 1 {
                NotificationCenter.default.post(name: .reloadCompletedView, object: nil, userInfo: nil)
            } else {
                NotificationCenter.default.post(name: .reloadActiveView, object: nil, userInfo: nil)
            }
            pageContentView.setCurrentIndex(currentIndex: index)
        }
    }
    
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        if self.titles.count >= 2 {
            pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        }
    }
}

// MARK: - Private Methods

extension ComplaintsBaseViewController {
    
    private func resetPageViewToFirstIndex() {
        pageContentView.setCurrentIndex(currentIndex: index)
        pageTitleView.currentLabelIndex = index
        pageTitleView.setTitleWithProgress(1.0, sourceIndex: 0, targetIndex: 0)
    }
    
    private func fetchConsentList() {
        callServiceRequestListAPI { (consernList, error) in
            if !error {
                self.mapConsentList(consernList: consernList!)
            }
        }
    }
    
    private func mapConsentList(consernList: ConsernList) {
        let status = consernList.status
        if status == 200 {
            self.resovledList = (consernList.concern?.filter({ (item) -> Bool in
                return item.status == "Resolved"
            }))!
            
            self.unResovledList = (consernList.concern?.filter({ (item) -> Bool in
                return item.status != "Resolved"
            }))!
        }
    }
}

// MARK: - WebServices

extension ComplaintsBaseViewController {
    
    func callServiceRequestListAPI(completionHandler: @escaping(ConsernList?, Bool) -> Void) {
        
        if !NetworkPreferences.isInternetConnectionAvailable() {
            showAlert(message: AlertMessage.noInternet, inViewController: self)
            return
        }
        let userId = SessionData.userId
        ServiceRequestClient.serviceRequestList(serviceRequestRouter: ServiceRequestRouter.requestList(userId: userId),
                                                   successCompletion: { (result) in
                                                    completionHandler(result, false)
        }, failureCompletion: { (error) in
            if let errorDetail  = error.general?[0] {
                showAlert(message: errorDetail.message!, inViewController: self)
            }
            completionHandler(nil, true)
        })
    }
}

