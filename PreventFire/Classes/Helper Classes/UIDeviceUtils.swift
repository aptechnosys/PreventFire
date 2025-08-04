//
//  UIDeviceUtils.swift
//  MICab
//
//  Created by Dinesh Bhadane on 6/8/18.
//  Copyright © 2018 Nilesh Patil. All rights reserved.
//

import Foundation
import UIKit
class UIDeviceUtils: UIDevice {

   class func getCurrentVersion() -> String {
        let versionNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    return versionNumber!
    }

  class  func getBuildVersion() -> String {

        let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
        return buildNumber!

    }
    class func getOsVersion() -> String {
        let systemVersion = UIDevice.current.systemVersion
        return systemVersion
    }
    class func getDeviceId() -> String {
        return (UIDevice.current.identifierForVendor?.uuidString)!
    }

}
