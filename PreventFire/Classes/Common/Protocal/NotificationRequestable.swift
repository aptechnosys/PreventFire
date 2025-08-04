//
//  NotificationRequestable.swift
//  Prevent Fire
//
//  Created by Shantaram Kokate on 1/30/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications

protocol NotificationRequestable {}

extension NotificationRequestable where Self: HomeViewController {
    
    internal typealias AuthorizedCompletion = (_ granted: Bool) -> Void
    
    func requestNotification (_ completion: AuthorizedCompletion? = nil) {
        
        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { (settings) in
            if settings.authorizationStatus == .notDetermined {
                DispatchQueue.main.async {
                    self.alertForDetermination(completion)
                }
            }
            
            if settings.authorizationStatus == .denied {
                DispatchQueue.main.async {
                    self.alertForDecline(completion)
                }
            }
            
            if settings.authorizationStatus == .authorized {
                DispatchQueue.main.async {
                    completion?(true)
                }
            }
        })
    }
    
    func registerPushNotification(_ completion: AuthorizedCompletion?) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .alert, .sound]) {(granted, _) in
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
            
            completion?(granted)
        }
    }
    
    func alertForDecline(_ completion: AuthorizedCompletion?) {
        showNotificationSettingPage(completion)
    }
    
    func alertForDetermination(_ completion: AuthorizedCompletion?) {
         self.registerPushNotification(completion)
    }
    
    func showNotificationSettingPage(_ completion: AuthorizedCompletion?) {
        let alertView = AlertView(title: LocalizedStrings.notifications, message: LocalizedStrings.notificationAccessMessage, okButtonText: LocalizedStrings.gotoSettting, cancelButtonText: AlertMessage.Cancel) { (_, button) in
            if button == .other {
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    DispatchQueue.main.async {
                        completion?(success)
                    }
                })
            }
        }
        alertView.show(animated: true)
    }
}
