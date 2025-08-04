//
//  SessionData.swift
//  PreventFire
//
//  Created by Shantaram Kokate on 9/22/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import Foundation

class SessionData {
    
    static let shared = SessionData()
    var isLoggedInUser: Bool?
    
    func clear() {
        isLoggedInUser      = nil
    }
    
    func checkIfTenantConfigurationArePresent() -> Bool {
        return true
    }
    
    static var userId: String {
        if let user = UserDefaults.standard.getUserId() {
            return user
        } else {
            return ""
        }
    }
    
    func fcmToken() -> String {
        var fcmToken = ""
        if let token =  UserDefaults.standard.value(forKey: DEVICETOKENKEY) as? String {
            fcmToken = token
        }
        return fcmToken
    }
}

class GuestSessionData {
    
    static let shared = GuestSessionData()
    var isGuestUser: Bool = false
    
    func clear() {
  
    }
}
