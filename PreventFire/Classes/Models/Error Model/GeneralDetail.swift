//
//  APIErrorDetail.swift
//  MICab
//
//  Created by Nilesh Patil on 5/22/18.
//  Copyright © 2018 Nilesh Patil. All rights reserved.
//

import Foundation

struct GeneralDetail: Codable {

    var messageCode: String?
    var message: String?

    enum CodingKeys: String, CodingKey {

        case messageCode
        case message
    }

    init(from decoder: Decoder) throws {

        let values = try decoder.container(keyedBy: CodingKeys.self)

        messageCode = try values.decodeIfPresent(String.self, forKey: .messageCode)

        message = try values.decodeIfPresent(String.self, forKey: .message)

    }
}
