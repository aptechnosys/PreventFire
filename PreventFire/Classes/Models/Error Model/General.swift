//
//  APIErrors.swift
//  MICab
//
//  Created by Nilesh Patil on 5/22/18.
//  Copyright © 2018 Nilesh Patil. All rights reserved.
//

import Foundation

struct General: Codable {

    var general: [GeneralDetail]?
    var numCountryCode: [GeneralDetail]?

    enum CodingKeys: String, CodingKey {

        case general
        case numCountryCode
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        general = try values.decodeIfPresent([GeneralDetail].self, forKey: .general)

        numCountryCode = try values.decodeIfPresent([GeneralDetail].self, forKey: .numCountryCode)

    }
    
    init () {
        
    }

}

struct AdditonalChargesGeneral: Codable {
    
    var status: String?
    enum CodingKeys: String, CodingKey {
        
        case status
        
    }
}
