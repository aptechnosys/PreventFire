//
//  ResolvedComplaintsViewController.swift
//  PreventFire
//
//  Created by Shantaram Kokate on 2/1/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit

import UIKit
import ESPullToRefresh
import SDWebImage

class ResolvedComplaintsViewController: AbstractViewController {
    
    // MARK: - IBOutlet

    @IBOutlet weak var listTableView: UITableView!

    // MARK: - Properties
    var activeServiceList = [String]()
    var pageOffset = 0
    var pageLimit = "10"
    
    var resovledList = [Resolved]()
    
    var menuList = [Concern]()
    // MARK: - VLC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewWillAppear(true)
        // Do any additional setup after loading the view.
        configureUI()
        fetchConsentList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.listTableView.removeAlertMessage()
        SDImageCache().clearMemory()
        self.listTableView.es.resetNoMoreData()
        pageOffset = 0
        activeServiceList.removeAll()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
}

// MARK: - Configure UI

extension ResolvedComplaintsViewController {
    
    func configureUI() {
        setupUI()
        addNotificationObserver()
        applyNavigatinBarColor()
        setupTableView()
        
    }
    
    fileprivate func setupUI() {
        listTableView.estimatedRowHeight = UnResolvedComplaintCell.cellHeight
        listTableView.rowHeight = UITableView.automaticDimension
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
}

// MARK: - UITable DataSource

extension ResolvedComplaintsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resovledList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: UnResolvedComplaintCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.unResolvedComplaintCell, for: indexPath as IndexPath) as? UnResolvedComplaintCell else {
            fatalError()
        }
        let consent  = resovledList[indexPath.row]
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

extension ResolvedComplaintsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let concern  = resovledList[indexPath.row]
        setServiceDetailView(concern: concern)
      }
}

// MARK: - Methods

extension ResolvedComplaintsViewController {
    
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
        }
    }
}
// MARK: - WebServices

extension ResolvedComplaintsViewController {
    
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

extension ResolvedComplaintsViewController {
    
    func setServiceDetailView(concern: Resolved) {
        let storyborad = UIStoryboard(name: StoryBoardName.serviceDetail.rawValue, bundle: nil)
        let serviceDetailViewController = storyborad.instantiateViewController(withIdentifier: "ServiceDetailViewController") as? ServiceDetailViewController
        serviceDetailViewController!.concern = concern
        self.navigationController?.pushViewController(serviceDetailViewController!, animated: true)
       }
}

// MARK: - PullToRefresh

extension ResolvedComplaintsViewController {
    
    func setUpPullToRefresh() {
        let header = self.listTableView.es.addInfiniteScrolling {
            [unowned self] in
            self.loadMore()
        }
        if let animator = header.animator as? ESRefreshFooterAnimator {
           /* animator.loadingDescription = LocalizedStrings.loadingMore
            animator.loadingMoreDescription = LocalizedStrings.loadingMore
            animator.noMoreDataDescription = LocalizedStrings.noNoreData */
            animator.refreshAnimationEnd(view: header)
        }
    }
    private func loadMore() {
        /*
        pageOffset += 10
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.callServiceRequestListAPI(completionHandler: { (result, error) in
                if !error {
                    if result?.pagination?.totalRecords == self.activeServiceList.count {
                        self.tableView.es.noticeNoMoreData()
                    } else {
                        self.tableView.es.stopLoadingMore()
                    }
                }
            })
        } */
    }
}
