//
//  FileUpload.swift
//  Prevent Fire
//
//  Created by Shantaram Kokate on 10/6/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import Foundation
struct FileUpload: Codable {

    let photo: String?
    let status: Int?
    
    enum CodingKeys: String, CodingKey {
        case photo
        case status
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        photo = try values.decodeIfPresent(String.self, forKey: .photo)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
    
}
