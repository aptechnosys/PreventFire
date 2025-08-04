//
//  ServiceRequestClient.swift
//  PreventFire
//
//  Created by Shantaram Kokate on 10/6/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ServiceRequestClient: Requestable {
    
    /*
     static func uploadImages(questionRouter: QuestionRouter, successCompletion: @escaping (EstimationFareModel) -> Void, failureCompletion: @escaping (General) -> Void) {
     
     _ = performRequest(route: questionRouter, successCompletion: { (response) in
     
     successCompletion(response)
     
     }, failureCompletion: { (response) in
     
     failureCompletion(response)
     })
     }
     
     static func createServiceRequest(serviceRequestRouter: ServiceRequestRouter, successCompletion: @escaping (EstimationFareModel) -> Void, failureCompletion: @escaping (General) -> Void) {
     
     _ = performRequest(route: serviceRequestRouter, successCompletion: { (response) in
     
     successCompletion(response)
     
     }, failureCompletion: { (response) in
     
     failureCompletion(response)
     })
     }
     */
    static func serviceRequestList(serviceRequestRouter: ServiceRequestRouter, successCompletion: @escaping (ConsernList) -> Void, failureCompletion: @escaping (General) -> Void) {
        
        _ = performRequest(route: serviceRequestRouter, successCompletion: { (response) in
            
            successCompletion(response)
            
        }, failureCompletion: { (response) in
            
            failureCompletion(response)
        })
    }
    
    static func allServiceRequestList(serviceRequestRouter: ServiceRequestRouter, successCompletion: @escaping (AllConcernModelBase) -> Void, failureCompletion: @escaping (General) -> Void) {
        
        _ = performRequest(route: serviceRequestRouter, successCompletion: { (response) in
            
            successCompletion(response)
            
        }, failureCompletion: { (response) in
            
            failureCompletion(response)
        })
    }
    
    static func alertList(serviceRequestRouter: ServiceRequestRouter, successCompletion: @escaping (AlertBase) -> Void, failureCompletion: @escaping (General) -> Void) {
        
        _ = performRequest(route: serviceRequestRouter, successCompletion: { (response) in
            
            successCompletion(response)
            
        }, failureCompletion: { (response) in
            
            failureCompletion(response)
        })
    }
    
    static func category(serviceRequestRouter: ServiceRequestRouter, successCompletion: @escaping (CategoryBaseModel) -> Void, failureCompletion: @escaping (General) -> Void) {
        
        _ = performRequest(route: serviceRequestRouter, successCompletion: { (response) in
            
            successCompletion(response)
            
        }, failureCompletion: { (response) in
            
            failureCompletion(response)
        })
    }
    
    /*static func serviceRequest(url:String, method:String, controller:UIViewController, parameters:Parameters, completion: @escaping (_ result: DataResponse<Any>) -> Void) {
        
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        headers["HeaderKey"] = "HeaderKey"
        var methodType: HTTPMethod = .post
        
        if method == "POST" {
            methodType = .post
        }
        else {
            methodType = .get
        }
        Alamofire.request(url, method: methodType, parameters: parameters, headers:headers
            ).responseJSON
            { response in
                
                DispatchQueue.main.async {
                    completion(response)
                }
        }
    }*/
    
    static func serviceRequest(url: String,
                               method: String,
                               controller: UIViewController,
                               parameters: Parameters,
                               completion: @escaping (_ result: DataResponse<Any, AFError>) -> Void) {
        
        var headers = HTTPHeaders.default
        headers["HeaderKey"] = "HeaderKey"
        
        let methodType: HTTPMethod = method.uppercased() == "POST" ? .post : .get

        AF.request(url, method: methodType, parameters: parameters, headers: headers)
            .responseJSON { response in
                DispatchQueue.main.async {
                    completion(response)
                }
            }
    }

    
}
