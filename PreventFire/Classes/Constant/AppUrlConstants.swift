//  PrenventFire
//
//  Created by Shantaram Kokate on 12/10/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import Foundation

struct APPURL {
    
    static var environment: Environment = .production
    
    private struct Domains {
        static let dev = ""
        static let uat = ""
        static let local = ""
        static let qualityAssurance = ""
        static let demo = ""
        static let preProduction = ""
        static let production = "https://www.firetechcorporations.com/fireadmin/api/"
        
    }
    
    private  struct Routes {
        static let signup = "user_registration"
    }
    
    static let Domain = Domains.dev
    static let Signup = Routes.signup
    
    static var Google: String {
        return "https://maps.googleapis.com/maps/api/"
    }
}

enum Environment {
    case development
    case uat
    case local
    case qualityAssurance
    case demo
    case preProduction
    case production
    
}

struct APIEndpoint {
    // let userId = UserDefaultUtils.sharedInstance.getUserDefaultsFromDB(key: USERID)
    //  static let register = "?request_type=user_registration&name=%@&password=%@&access=%@&status=%@&mobile_no=%@&email_id=%@&photo=%@&gcmid=%@&device_id=%@&language=%@"
    static let register = "?request_type=user_registration&name=%@&lastname=%@&password=%@&access=%@&status=%@&mobile_no=%@&email_id=%@&photo=%@&gcmid=%@&device_id=%@&language=%@&countrycode=%@"
    
    static let uploadImage = "?request_type=uploadprofilephoto"
    static let login = "?request_type=login&username=%@&password=%@&gcmid=%@"
    static let forgotPassword = "?request_type=forgotpassword&username=%@"
    
    static let verifyOtp = "users/verify-otp"
    static let logout = "secure/users/logout"
    static let setPassword = "users/set-password"
    static let changePassword = "secure/users/%@/change-password"
    static let updateProfile = "secure/users/%@"
    static let profile = "secure/users/%@"
    static let appversion = "app-version"
    
    static let addAddress = "secure/users/%@/addresses"
    static let getAddress = "secure/users/%@/addresses"
    static let deleteAddress = "secure/users/%@/addresses/%@"
    static let updateAddress = "secure/users/%@/addresses/%@"
    static let faq = "secure/faqs"
    static let privacySettings = "privacy-settings"
    static let addPrivacySettings = "secure/users/%@/privacy-settings"
    static let getUserPrivacySettings = "secure/users/%@/privacy-settings"
    static let metaData = "%@/metadata"
    static let questionnaires = "questionnaires?serviceId=%@&categoryId=%@"
    static let estimation = "secure/service-request-estimations"
    static let estimationById = "secure/service-request-estimations/%@/surge-discount"
    static let profileImageUpload = "/file/upload-signup-profile-image?fileType=image&uploadType=avatar"
    static let documentImageUpload = "secure/file?fileType=image&uploadType=file"
    static let fileUrl = "secure/file/%@"
    static let csvTextUpload = "secure/file"
    static let createServiceRequest = "secure/service-requests"
    static let verifyPromoCode = "secure/promo-codes/%@/verify?type=%@"
    static let addUserCardDetails = "secure/users/%@/card-details"
    static let getUserCardDetails = "secure/users/%@/card-details"
    static let setPrimaryCard = "secure/users/%@/card-details/%@/set-primary"
    static let deleteUserCardDetails = "secure/users/%@/card-details/%@"
    static let mostPopularServices = "services-list?categoryIds=&status=true&popular=true"
    static let privacyPolicy = "tenants/privacy-policy"
    static let aboutus = "tenants/about-us"
    static let support = "tenants/contact-support"
    static let termsAndConditions = "tenants/terms-and-conditions"
    static let downloadFile = "secure/file"
    static let notificationList = "secure/notifications?limit=%@&offset=%@"
    static let deleteNotification = "secure/notifications/%@"
    static let readNotification = "secure/notifications"
    static let unreadNotificationCount = "secure/notifications-count"
    static let userServiceRequest = "secure/service-requests-list?offset=%@&limit=%@&type=%@"
    static let serviceRequestDetail = "secure/service-requests/%@"
    static let updateServiceStatus = "secure/service-requests/%@/set-status"
    static let sendOTP = "users/send-otp"
    static let cancellationCharges = "/secure/cancellation-charges?serviceId=%@&categoryId=%@"
    static let statuses = "secure/service-statuses-list?action=excludingRegret&status=true"
    static let rateRequest = "secure/service-requests/%@/rate-request"
    static let additionalChargesStatus = "secure/service-requests/%@/additional-charges/%@/set-status"
    static let facebookLogin = "users/login/facebook"
    static let deleteUser = "secure/users/%@/delete-user-data"
    static let exportUserData = "secure/users/%@/export-csv"
    static let verifyEmailAndPhone = "users/verify-email-phone"
    static let aboutUs = "secure/tenants"
    static let updateUserPrivacySettings = "secure/users/%@/privacy-settings"
    static let createRequest = "request_type=addenquiery"
    // static let createRequest = "?request_type=addenquiery&locationlat=%@&locationlong=%@&address=%@&city=%@&state=%@&message=%@&status=%@&uid=%@&category=%@&peopleaffected=%@&showchkbox=%@&photo=%@&buildingname=%@"
    
    
    static let showallAlerts = "?request_type=showallalerts&uid=%@"
    static let showallConcern = "?request_type=select_enquiry&uid=%@"
    static let category = "?request_type=category&id=%@"
    static let selectEnquiry = "?select_enquiry=category&enquiry_id=%@"
    static let allComplaints = "?request_type=showallconcern&uid=%@"
    static let uploadComplaintImage = "?request_type=uploadcomplainphoto"
    
    //Google
    struct Google {
        static let autocomplete = "https://maps.googleapis.com/maps/api/place/autocomplete/json?"
        static let geoAddress = "https://maps.googleapis.com/maps/api/geocode/json?"
    }
}

extension APPURL {
    
    static func setDevelopmentEnvironment(_ envi: Environment) {
        APPURL.environment = envi
    }
    
    static func baseUrl() -> String {
        switch environment {
        case .development:  return  Domains.dev
        case .uat:  return  Domains.uat
        case .local:    return Domains.local
        case .qualityAssurance:     return Domains.qualityAssurance
        case .demo:     return Domains.demo
        case .preProduction:    return Domains.preProduction
        case .production:    return Domains.production
            
        }
    }
}

struct TENANTID {
    static let tenantid = "T001"
}

struct Role {
    static let customer = "customer"
    static let admin = "admin"
    
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case acceptLangauge = "Accept-Language"
}

enum ContentType: String {
    case json = "application/json"
    case multipart = "multipart/form-data"
    case ENUS = "en-US"
}

struct Key {
    struct APIParameter {
        static let googleMapkey = "googleMapkey"
        
        static let user = "user"
        static let email = "email"
        static let mobile = "mobile"
        static let password = "password"
        static let tenantId = "tenantId"
        static let deviceDetails = "deviceDetails"
        static let appVersion = "appVersion"
        static let deviceId = "deviceId"
        static let deviceType = "deviceType"
        static let operatingSystem = "os"
        static let osVersion = "osVersion"
        static let notificationToken = "notificationToken"
        static let phoneNum = "phoneNum"
        static let numCountryCode = "numCountryCode"
        static let otp = "otp"
        static let otpId = "otpId"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let facebookId = "facebookId"
        static let token = "token"
        static let username = "username"
        static let userDetails = "userDetails"
        static let referralCode = "referralCode"
        static let corporateId = "corporateId"
        static let departmentId = "departmentId"
        static let profileImage = "profileImage"
        static let defaultTimezone = "defaultTimezone"
        static let defaultLanguage = "defaultLanguage"
        static let roleCode = "roleCode"
        static let userId = "userId"
        static let type = "type"
        static let oldPassword = "oldPassword"
        static let newPassword = "newPassword"
        static let locationName = "locationName"
        static let streetNum = "streetNum"
        static let flatNum = "flatNum"
        static let zipCode = "zipCode"
        static let addressNickname = "addressNickname"
        static let addressLine1 = "addressLine1"
        static let addressLine2 = "addressLine2"
        static let landmark = "landmark"
        static let countryCode = "countryCode"
        static let stateCode = "stateCode"
        static let cityId = "cityId"
        static let poBox = "poBox"
        static let addressLatitude = "addressLatitude"
        static let addressLongitude = "addressLongitude"
        static let usersPrivacySettingModelList = "usersPrivacySettingModelList"
        static let serviceStatusId = "serviceStatusId"
        static let cancellationReason = "cancellationReason"
        static let cancelComment = "cancelComment"
        static let rating = "rating"
        static let comment = "comment"
        static let status = "status"
    }
}
