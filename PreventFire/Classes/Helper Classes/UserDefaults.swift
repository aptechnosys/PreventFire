//
//  UserDefaults.swift
//  PreventFire
//
//  Created by Shantaram Kokate on 2/4/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit

//Mark: UserDefaultsKeys
extension UserDefaults {
    enum UserDefaultsKeys: String {
        case userName
        case mobileNumber
        case email
        case address
        case userId
        case imageUrl
        case language
        case googleMapKey
        case lastName
        case countryCode

    }
}

// Mark: - User Data
extension UserDefaults {

    func set(language: String) {
        set(language, forKey: UserDefaultsKeys.language.rawValue)
        synchronize()
    }

    func set(userId: String) {
        set(userId, forKey: UserDefaultsKeys.userId.rawValue)
        synchronize()
    }

    func set(imageUrl: String) {
        set(imageUrl, forKey: UserDefaultsKeys.imageUrl.rawValue)
        synchronize()
    }
    
    func set(userName: String) {
        set(userName, forKey: UserDefaultsKeys.userName.rawValue)
        synchronize()
    }
    
    func set(mobileNumber: String) {
        set(mobileNumber, forKey: UserDefaultsKeys.mobileNumber.rawValue)
        synchronize()
    }
    
    func set(emilAddress: String) {
        set(emilAddress, forKey: UserDefaultsKeys.email.rawValue)
        synchronize()
    }
    
    func set(address: String) {
        set(address, forKey: UserDefaultsKeys.address.rawValue)
        synchronize()
    }
    
    func set(lastName: String) {
        set(lastName, forKey: UserDefaultsKeys.lastName.rawValue)
        synchronize()
    }
    
    func set(countryCode: String) {
        set(countryCode, forKey: UserDefaultsKeys.countryCode.rawValue)
        synchronize()
    }
    
    func getUserName() -> String? {
        return string(forKey: UserDefaultsKeys.userName.rawValue)
    }
    
    func getLastName() -> String? {
        return string(forKey: UserDefaultsKeys.lastName.rawValue)
    }
    
    func getcountryCode() -> String? {
        return string(forKey: UserDefaultsKeys.countryCode.rawValue)
    }

    func getUserId() -> String? {
        return string(forKey: UserDefaultsKeys.userId.rawValue)
    }
    
    func getImageUrl() -> String? {
        return string(forKey: UserDefaultsKeys.imageUrl.rawValue)
    }
    
    func getMobileNumber() -> String? {
        return string(forKey: UserDefaultsKeys.mobileNumber.rawValue)
    }
    
    func getEmailNumber() -> String? {
        return string(forKey: UserDefaultsKeys.email.rawValue)
    }
    
    func getAddressNumber() -> String? {
        return string(forKey: UserDefaultsKeys.address.rawValue)
    }

    func getLanguage() -> String? {
        return string(forKey: UserDefaultsKeys.language.rawValue)
    }

    func clearUser() {
        removeObject(forKey: UserDefaultsKeys.userId.rawValue)
    }
}
