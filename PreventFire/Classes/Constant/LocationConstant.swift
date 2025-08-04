//  PrenventFire
//
//  Created by Shantaram Kokate on 12/10/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//
import UIKit

struct LocationInformation {
    
    static let name         = "location_name"
    static let streetNumber = "street_number"
    static let flatNumber   = "flat_number"
    static let zipCode      = "zip_code"
    static let postalCode   = "postal_code"
    static let nickName     = "address_nickname"
    static let premise      = "premise"
    static let latitude      = "latitude"
    static let longitude      = "longitude"
}

class LocationInformationManager {
    var name         = ""
    var streetNumber = ""
    var flatNumber   = ""
    var zipCode      = ""
    var postalCode   = ""
    var nickName     = ""
    var premise      = ""
    var latitude      = 0.0
    var longitude      = 0.0
    
}
