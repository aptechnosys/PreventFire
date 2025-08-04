//
//  Constant.swift
//
//  Created by Shantaram Kokate on 08/16/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import Foundation
import UIKit
let kGTMKey = ""
var kGOOGLEMAPKEY = "AIzaSyC631OGdyhCV_YsIzH0OA-fwvWLm3XWMrc"
let ZIPCODEAVAILABILITY = "i0YBmSoDWEgfFq1IfsM5bcjHzR0UToWya0lAH5kfSAZtFzSSTsiS7w=="
let IOS = "ios"
let EMAIL = "email"
let USERID = "userId"
let PHONENUMBER = "phoneNo"
let FIRSTNAME = "firstName"
let LASTNAME = "lastName"
let FULLNAME = "fullname"
let TENANTIDKEY = "tenantId"
let DEVICETOKENKEY = "DeviceTokenKey"
let SESSIONKEY = "session"
let COUNTRYCODE = "countryCode"
let EMAILVERIFIED = "emailVerified"
let PHONENUMVERIFIED = "phoneNumVerified"
let VATINFO = "vatInfo"
let STREETNUM = "StreetNum"
let FLATNUM = "flatNumberAndApartment"
let ZIPCODE = "zipcode"
let SELECTEDZIPCODE = "selectedZipcode"
let CARDNUMBER = "XXXX-XXXX-XXXX-"
let ISAPPTUTORIALCOMPLETED = "isAppTutoiralCompleted"
let ISZIPCHECKFITSTTIME = "isZipcodeFirstTime"

enum StoryBoardName: String {
    case menu       = "Menu"
    case login      = "Login"
    case setting    = "Setting"
    case serviceRequest = "ServiceRequest"
    case home       = "Home"
    case serviceDetail       = "ServiceDetail"
    case magazine       = "Magazine"
}

struct AppConstants {
    //static let appDelegate: AppDelegate = UIApplication.shared.delegate
}

struct StoryboradIdentifier {
    static let forgetPassword = "ForgetPasswordViewController"
    static let singup = "SignupViewController"
    static let jobDetailPageView = "ServiceDetailsViewController"
    static let jobStatusView = "StatusViewController"
    static let questionsView = "QuestionsViewController"
    static let canelService = "CancelServiceViewController"
    static let rateService = "RateServiceViewController"
    static let serviceRequestDetailView = "ServiceRequestDetailViewController"
    static let serviceRequestAddressView = "ServiceRequestAddressViewController"
    static let adddressesView = "AddressesViewController"
    static let locationView = "LocationViewController"
    static let addAddressView = "AddAddressViewController"
    static let orderSummaryView = "OrderSummaryViewController"
    static let hsAlertView = "HSAlertViewController"
    static let consentView = "ConsentViewController"
    static let serviceUpdateAlert = "ServiceUpdateAlertViewController"
    static let cancellationRuleView = "CancellationRulesViewController"
    static let checkAvailabilityView = "CheckAvailabilityViewController"
    static let informationPopupView = "InformationPopupViewController"
    static let additionalCharges = "AdditionalChargesPopupViewController"
    static let accountSettingsView = "AccountSettingsViewController"
    static let passwordPopupView = "PasswordPopupViewController"
}
struct CellIdentifier {
    static let languageCell = "LanguageCell"
    static let leftMenuCell = "LeftMenuTableViewCell"
    static let categoryCell =  "CategoryCell"
    static let unResolvedComplaintCell = "UnResolvedComplaintCell"
    static let magazineCell = "MagazineCell"
    static let newsFeedsCell = "NewsFeedsCell"


 }

struct Unicode {
    static let euro = "\u{20AC}"
    static let bullet = "\u{25CF}"
    static let percent = "%"
}

struct Database {
    static  let  fileName = "Faustudo"
}

enum MultipartType: String {
    case image = "Image"
    case csv = "CSV"
}

enum MimeType: String {
    case image = "image/png"
    case csvText = "text/csv"
}

struct DateFormat {
    static let dateFormat = "dd MMM, yyyy"
    static var timeFormat = "kk:mm"
    
    static var format: String {
        return dateFormat + " " + timeFormat
    }
}
