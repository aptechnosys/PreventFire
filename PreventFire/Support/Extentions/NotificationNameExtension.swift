//
//  NotificationNameExtension.swift
//  PrenventFire
//
//  Created by Shantaram Kokate on 12/10/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit

extension NSNotification.Name {
    
    static var reloadCompletedView: NSNotification.Name {
        return NSNotification.Name(rawValue: "ReloadCompletedView")
    }
    
    static var reloadActiveView: NSNotification.Name {
        return NSNotification.Name(rawValue: "ReloadActiveView")
    }
    
    static var notificationReloadView: NSNotification.Name {
        return NSNotification.Name(rawValue: "Notification.ReloadView")
    }
    
    static var reloadServiceDetailView: NSNotification.Name {
        return NSNotification.Name(rawValue: "ServiceDetail.ReloadView")
    }
    
}
