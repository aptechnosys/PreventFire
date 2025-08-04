//
//  LoginRouter.swift
//  Prevent Fire
//
//  Created by Shantaram Kokate on 9/17/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import Foundation
import Alamofire

enum LoginRouter: APIConfiguration {
    
    case signup(name: String, lastName: String, password: String, access: String, status: String, mobile_no: String, email_id: String, photo: String, gcmid: String, device_id: String, language: String, countrycode: String)
    case login(email: String, password: String)
    case logout
    case forgotPassword(userName: String)
    case uploadImage
    case countryList
    
    var userId: (String) {
        let userId = ""
        return userId
    }
    
    
    
    internal var requestType: HTTPMethod {
        switch self {
        case .forgotPassword, .uploadImage:
            return .post
        case .login, .signup, .countryList:
            return .get
        case .logout:
            return .delete
        }
    }
    
    internal var path: String {
        switch self {
        case .signup(let name, let lastName, let password, let access, let status, let mobileNo, let emailId, let photo, let gcmId, let deviceId, let language, let countrycode):
            return String(format: APIEndpoint.register, name,lastName, password, access, status, mobileNo, emailId, photo, gcmId, deviceId, language, countrycode)
        case .login(let email, let password):
            let token = SessionData.shared.fcmToken()
            return String(format: APIEndpoint.login, email, password, token)
        case .logout:
            return APIEndpoint.logout
        case .forgotPassword(let userName):
            return String(format: APIEndpoint.forgotPassword, userName)
        case .uploadImage:
            return APIEndpoint.uploadImage
        case .countryList:
            return APIEndpoint.uploadImage
        }
    }
    
    internal var parameters: Parameters? {
        
        switch self {
            
        case .signup, .countryList:
            return nil
            
        case .login:
            
            return nil
            
        case .logout:
            return [:]
            
        case .forgotPassword:
            return nil
            
        case .uploadImage:
            return [:]
        }
    }
}
