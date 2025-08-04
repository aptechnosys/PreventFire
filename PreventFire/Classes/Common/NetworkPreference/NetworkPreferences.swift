import UIKit
import Reachability

private var _sharedInstance: NetworkPreferences?

class NetworkPreferences: NSObject {

    var reachability: Reachability!
    fileprivate var hasInternetConnection: Bool! = false

    fileprivate override init() {

    }

    class var sharedInstance: NetworkPreferences {
        if _sharedInstance == nil {
            _sharedInstance = NetworkPreferences()
            _sharedInstance?.setupReachability()
        }
        return _sharedInstance!
    }

    class func isInternetConnectionAvailable() -> Bool {

        return NetworkPreferences.sharedInstance.hasInternetConnection!
    }

    func setupReachability() {
        NotificationCenter.default.addObserver(self, selector: #selector(NetworkPreferences.handleNetworkChange), name: Notification.Name.reachabilityChanged, object: nil)

        do {
            // Initialize Reachability - mark with try because it throws
            self.reachability = try Reachability()

            do {
                try self.reachability.startNotifier()

                let remoteHostStatus = self.reachability.connection

                if remoteHostStatus == .none {
                    self.hasInternetConnection = false
                } else if remoteHostStatus == .wifi {
                    self.hasInternetConnection = true
                } else if remoteHostStatus == .cellular {
                    self.hasInternetConnection = true
                }

            } catch let error as NSError {
                NSLog("Reachability Error in starting notifier \(error)")
            }
        } catch let error {
            NSLog("Reachability Initialization Error: \(error.localizedDescription)")
        }
    }


    @objc func handleNetworkChange(_ notification: Notification) {

        let remoteHostStatus = self.reachability.connection

        if remoteHostStatus == .none {

            self.hasInternetConnection = false

        } else if remoteHostStatus == .wifi {

            self.hasInternetConnection = true

        } else if remoteHostStatus == .cellular {

            self.hasInternetConnection = true
        }
    }
}
