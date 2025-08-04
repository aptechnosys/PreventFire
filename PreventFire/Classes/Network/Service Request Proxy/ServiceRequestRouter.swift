//
//  ServiceRequestRouter.swift
//  Prevent Fire
//
//  Created by Shantaram Kokate on 10/6/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import Foundation
import Alamofire

enum ServiceRequestRouter: APIConfiguration {
    
   // case create(serviceRequest: CreateServiceRequest)
    case create(request: RequestModel)
    case requestList(userId: String)
    case alert(userId: String)
    case allComplaints(userId: String)
    case category(id: String)

    var requestType: HTTPMethod {
        switch self {
        case .create:
            return .post
        case .requestList:
            return .get
        case .alert, .category:
            return .get
        case .allComplaints:
            return .get
        }
    }
    
    internal var path: String {
        switch self {
        case .create(_):
             return ""
        case .requestList(let userId):
            return String(format: APIEndpoint.showallConcern, userId)
            
        case .alert(let userId):
            return String(format: APIEndpoint.showallAlerts, userId)
            
        case .category(let cateId):
            return String(format: APIEndpoint.category, cateId)
            
        case .allComplaints(let userId):
            return String(format: APIEndpoint.allComplaints, userId)

        }
        
    }
    
    var parameters: Parameters? {
        switch self {
       case .create(let requestModel):
          return requestModel.convertToDictionary(data: requestModel.serialize())
        case .requestList, .alert, .category, .allComplaints:
            return nil
        }
    }
    
}
