//
//  GlobalHelper.swift
//  PreventFire
//
//  Created by Shantaram Kokate on 9/17/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

// MARK: - UIAlert Method

func showAlert(message: String, inViewController: AlertViewDelegate) {
     let alertView = AlertView(title: AlertMessage.alert,
                              message: message,
                              okButtonText: AlertMessage.Okay,
                              cancelButtonText: "",
                              target: inViewController)
    alertView.show(animated: true)
}
func showAlert(title: String, message: String, inViewController: AlertViewDelegate) {
    let alertView = AlertView(title: title.localized(),
                              message: message,
                              okButtonText: AlertMessage.Okay,
                              cancelButtonText: "",
                              target: inViewController)
    alertView.show(animated: true)
}

// MARK: - Application Loader

func showLoader() {
    SVProgressHUD.setDefaultMaskType(.custom)
    SVProgressHUD.show()
}

func dismissLoader() {
    SVProgressHUD.dismiss()
}

// MARK: - Notification Handler

func isApplicableForNextView(notificationStatus: String) -> Bool {
    if notificationStatus == NotificationType.assignedServiceToProvider || notificationStatus == NotificationType.serviceStatusCompleted || notificationStatus == NotificationType.updatedBookingAdjustment || notificationStatus == NotificationType.serviceStatusCancelled || notificationStatus == NotificationType.newServiceRequested || notificationStatus == NotificationType.serviceStatusRegreted || notificationStatus == NotificationType.paymentFailure || notificationStatus == NotificationType.paymentSuccess || notificationStatus == NotificationType.serviceStatusAssigned || notificationStatus == NotificationType.serviceStatusAccepted || notificationStatus == NotificationType.addedAdditionalCharges || notificationStatus == NotificationType.serviceStatusUpdated || notificationStatus == NotificationType.upcomingServiceRequest {
        return true
    }
    return false
}

func getSeparatedExtraParamsOfNotification(extraParam: String) -> (notificationStatus: String, serviceId: String) {
    let extraParamsArray: [String] = (extraParam.components(separatedBy: "~"))
    let notificationStatus = extraParamsArray[0]
    let serviceId = extraParamsArray[1]
    return (notificationStatus, serviceId)
}

// MARK: - UIImage URL Handler

enum ImageSize {
    case original
    case thumbnail
}

func imagePathForId(_ imageId: String, ForImagesize size: ImageSize) -> String {
    var urlString: String!
    if size == .thumbnail {
        urlString =  String(format: "%@%@/thumbnail_%@", APPURL.baseUrl(), APIEndpoint.downloadFile, imageId)
    } else {
        urlString =  String(format: "%@%@/%@", APPURL.baseUrl(), APIEndpoint.downloadFile, imageId)
    }
    let urlwithPercent = urlString.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    return urlwithPercent!
}

// MARK: - Print

func print(items: Any..., separator: String = " ", terminator: String = "\n") {
    
    #if DEBUG
    
    var idx = items.startIndex
    let endIdx = items.endIndex
    
    repeat {
        Swift.print(items[idx], separator: separator, terminator: idx == (endIdx - 1) ? terminator : separator)
        idx += 1
    }
        while idx < endIdx
    
    #endif
} 
