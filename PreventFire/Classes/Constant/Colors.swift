//  PrenventFire
//
//  Created by Shantaram Kokate on 12/10/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//
import Foundation
import UIKit

struct RGBColor {
    static let themeColor = "79,22,111,1.0"
    static let gray = "51,51,51"
    static let darkGray = "82,82,82,1.0"
    static let white = "256,256,256,1.0"
    static let lightGray = "203,203,203,1.0"
    static let searchicon = "203,203,203,1.0"
    static let viewBackgroundColor = "239,239,239,1.0"
    static let buttonBackgroundColor = "254,172,0,1.0"
    static let segmentBarSelectTitleColor = white
    static let segmentBarDeSelectTitleColor = "254,245,192,1.0"
    static let amountColor = "52,219,154,1.0"
    static let facebookBackgroundColor = "59,89,152,1.0"
    static let lineSeperatorColor = "150,150,150,1.0"
    static let addressTypeBackgroundColor = "235, 235, 235,1.0"
     static let addressTypeTextColor = "150,150,150,1.0"
    static let addressTextColor = "82,82,82,1.0"
    static let jobInProgressTextColor = "55,222,146,1.0"
    static let jobCompletedStatusBackgroundColor = themeColor
    static let jobInActiveStatusBackgroundColor = "228,228,228,1.0"
    static let cellDropShadowColor = "228,228,228,1.0"
    static let lightGreenColor = "55,222,146,1.0"
    static let tableHeaderBackgroundcolor = "241,241,243,1.0"
    static let serviceDetailTextcolor = "82,82,82,1.0"
    static let popUpTextViewBackgroundColor = "243,243,243,1.0"
    static let popUpTextViewTextColor = "203,203,203,1.0"
    static let popUpSubHeaderTextColor = "40,40,40,1.0"
    static let popUpHeaderTextColor = "20,20,20,1.0"
}

extension UIColor {
    static let graysColor = getUIColor(RGBColor.gray)
    static let themeColor = getUIColor(RGBColor.themeColor)
    static let searchicon = getUIColor(RGBColor.searchicon)
     static let darkGrayColor = getUIColor(RGBColor.darkGray)
    static let lightGrayColor = UIColor.getUIColor(RGBColor.lightGray)
    static let navBarColor = getUIColor(RGBColor.themeColor)
    static let navBarLightGreenColor = getUIColor(RGBColor.lightGreenColor)
    static let navBarTitleColor = getUIColor(RGBColor.white)
    static let viewBackgroundColor = getUIColor(RGBColor.viewBackgroundColor)
    static let buttonBackgroundColor = getUIColor(RGBColor.buttonBackgroundColor)
    static let buttonLightGreenBackgroundColor = getUIColor(RGBColor.lightGreenColor)
    static let segmentBarSelectTitleColor = getUIColor(RGBColor.segmentBarSelectTitleColor)
    static let segmentBarDeSelectTitleColor = getUIColor(RGBColor.segmentBarDeSelectTitleColor)
    static let amountColor = getUIColor(RGBColor.amountColor)
    static let facebookBackgroundColor = getUIColor(RGBColor.facebookBackgroundColor)
    static let lineSeperatorBackgroundColor = getUIColor(RGBColor.lineSeperatorColor)
    static let addressTypeBackgroundColor = getUIColor(RGBColor.addressTypeBackgroundColor)
    static let addressTypeTextColor = getUIColor(RGBColor.addressTypeTextColor)
    static let addressTextColor = getUIColor(RGBColor.addressTextColor)
    static let jobInProgressTextColor = getUIColor(RGBColor.jobInProgressTextColor)
    static let jobCompletedBarStatusBackgroundColor = getUIColor(RGBColor.jobCompletedStatusBackgroundColor)
    static let jobInActiveBarStatusBackgroundColor = getUIColor(RGBColor.jobInActiveStatusBackgroundColor)
    static let cellDropShadowColor = getUIColor(RGBColor.cellDropShadowColor)
    static let tableHeaderBackgroundcolor = getUIColor(RGBColor.tableHeaderBackgroundcolor)
    static let serviceDetailTextcolor = getUIColor(RGBColor.serviceDetailTextcolor)
    static let popUpTextViewBackgroundColor = getUIColor(RGBColor.popUpTextViewBackgroundColor)
    static let popUpTextViewTextColor = getUIColor(RGBColor.popUpTextViewTextColor)
    static let popUpSubHeaderTextColor = getUIColor(RGBColor.popUpSubHeaderTextColor)
    static let popUpHeaderTextColor = getUIColor(RGBColor.popUpHeaderTextColor)
    
    static func  getUIColor(_ cType: String) -> UIColor {
        
        func getCGFloat(string: String) -> CGFloat? {
            /*
            if let num = NumberFormatter().number(from: string) {
                LogLogger.shared.setLog("\(num)", forKey: UIComponent.UserDefineAlphaValue)
                return CGFloat(num.floatValue)
            } else {
                LogLogger.shared.setLog("Error : 1.0", forKey: UIComponent.DefualtAlphaValue)
                return 1.0
            } */
            
            var cgFloat: CGFloat?
            
            if let doubleValue = Double(string) {
                cgFloat = CGFloat(doubleValue)
            } else {
                cgFloat = 1.0
            }
            return cgFloat
        }
        
        let array = cType.components(separatedBy: ",")
        if array.count > 3 {
            let alphaValue: CGFloat = getCGFloat(string: array[3])!
            let rgbValue = String(format: "%@,%@,%@", array[0], array[1], array[2])
            return UIColor.init(rgb: rgbValue, alpha: alphaValue)
        }
        return UIColor.init(rgb: cType, alpha: 1.0)
    }
}
