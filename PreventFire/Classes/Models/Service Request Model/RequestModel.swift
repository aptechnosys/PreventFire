//
//  RequestModel.swift
//  PreventFire
//
//  Created by Shantaram Kokate on 2/1/19.
//  Copyright © 2019 Shantaram Kokate. All rights reserved.
//

import UIKit

struct RequestModel: Serializable {
    
    let locationlat: String?
    let locationlong: String?
    let address: String?
    let city: String?
    let state: String?
    let message: String?
    let status: String?
    let uid: String?
    let buildingname: String?
    let category: String?
    let peopleaffected: String?
    let showchkbox: String?
    let photo: String?
    let request_type: String?
}
