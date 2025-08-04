 //
//  Requestable.swift
//  Prevent Fire
//
//  Created by Shantaram Kokate on 9/12/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

protocol Requestable {}

extension Requestable {
    static func performRequest<T: Decodable>(route: APIConfiguration,
                                             successCompletion:@escaping (T) -> Void,
                                             failureCompletion:@escaping (General) -> Void) -> DataRequest {
        print("API URL:\(route.path), Paramters:\(String(describing: route.parameters))")
        let manager = AF
        manager.session.configuration.timeoutIntervalForRequest = 60
        manager.session.configuration.requestCachePolicy = .returnCacheDataElseLoad
        return manager.request(route)
            .responseData(queue: .main, completionHandler: { (response ) in
                
                DispatchQueue.main.async {
                    
                    if case .failure(_) = response.result {
                        let decoder = JSONDecoder()
                        //var errorMsg = "server_error".localized()
                        //let code  =  response.error?._code
                        
                        let errorMsg  = (response.error?.localizedDescription)!
                        print(errorMsg)
                        let errorDict = ["general": [["messageCode": "", "message": LocalizedStrings.slowNetworkError]]]
                        do {
                            let errorData = try JSONSerialization.data(withJSONObject: errorDict, options: .prettyPrinted)
                            let decodedData = try? decoder.decode(General.self, from: errorData)
                            failureCompletion(decodedData!)
                        } catch {
                            print(error.localizedDescription)
                        }
                    } else {
                        let decoder = JSONDecoder()
                        if response.response?.statusCode == 200 {
                            do {
                                if let json = try JSONSerialization.jsonObject(with: response.data!, options: []) as? NSDictionary {
                                    print(json)
                                }
                                if let json = try JSONSerialization.jsonObject(with: response.data!, options: []) as? NSArray {
                                    print(json)
                                }
                            } catch let error as NSError {
                                print("Failed to load: \(error.localizedDescription)")
                            }
                            let decodedData = try? decoder.decode(T.self, from: response.data!)
                            
                            if decodedData == nil {
                                //failureCompletion(General())
                                let errorDict = ["general": [["messageCode": "", "message": AlertMessage.SomethingWentWrong]]]
                                do {
                                    let errorData = try JSONSerialization.data(withJSONObject: errorDict, options: .prettyPrinted)
                                    let decodedData = try? decoder.decode(General.self, from: errorData)
                                    failureCompletion(decodedData!)
                                } catch {
                                    print(error.localizedDescription)
                                }
                            } else {
                                successCompletion(decodedData!)
                            }
                        } else {
                            do {
                                if let json = try JSONSerialization.jsonObject(with: response.data!, options: []) as? NSDictionary {
                                    print(json)
                                }
                            } catch let error as NSError {
                                print("Failed to load: \(error.localizedDescription)")
                            }
                            
                            let decodedData = try? decoder.decode(General.self, from: response.data!)
                            if decodedData != nil {
                                if let errorDetail  = decodedData?.general?[0] {
                                    print(errorDetail as Any)
                                    print(route.urlRequest! as Any)
                                    print(route.parameters ?? "")
                                }
                                failureCompletion(decodedData!)
                            } else {
                                failureCompletion(General())
                            }
                        }
                    }
                }
            })
    }
    
    static  func postMultipartData(multiPartType: MultipartType, fileName: String, apiEndPoint: String, imageData: Data, successCompletion:@escaping (FileUpload) -> Void, failureCompletion:@escaping (General) -> Void ) {
        
        // var url = APPURL.baseUrl + APIEndpoint.csvTextUpload
        let baseURL = APPURL.baseUrl()
        var url =  String(format: "%@%@", baseURL, apiEndPoint)
        var mimeType = MimeType.csvText.rawValue
        if multiPartType.rawValue == MultipartType.image.rawValue {
            //url = APIEndpoint.baseUrl() + APIEndpoint.profileImageUpload
            url = String(format: "%@%@", baseURL, apiEndPoint)
            mimeType = MimeType.image.rawValue
        }
        
        var headers: HTTPHeaders = [
            HTTPHeaderField.contentType.rawValue: ContentType.multipart.rawValue,
            HTTPHeaderField.acceptLangauge.rawValue: ContentType.ENUS.rawValue
        ]
        
         let apiSessionKey = "SessionKey"
            let sessionKey = "Bearer " + apiSessionKey
            headers[HTTPHeaderField.authentication.rawValue] = sessionKey
        
        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "file[]", fileName: fileName, mimeType: mimeType)
            },
            to: url,
            method: .post,
            headers: headers
        )
        .responseJSON { response in
            let decoder = JSONDecoder()
            if response.response?.statusCode == 200 {
                do {
                    if let json = try JSONSerialization.jsonObject(with: response.data!, options: []) as? NSDictionary {
                        print(json)
                    }
                    let decodedData = try decoder.decode(FileUpload.self, from: response.data!)
                    DispatchQueue.main.async {
                        successCompletion(decodedData)
                    }
                } catch {
                    print("Decoding error:", error)
                }
            } else {
                // Error response
                do {
                    if let json = try JSONSerialization.jsonObject(with: response.data!, options: []) as? NSDictionary {
                        print(json)
                    }
                    let decodedData = try decoder.decode(General.self, from: response.data!)
                    DispatchQueue.main.async {
                        failureCompletion(decodedData)
                    }
                } catch {
                    print("Decoding error:", error)
                }
            }
        }

    }
    
    //Multipart image upload

    static func uploadImageWithParameters(url: URL,
                                          parameters: NSDictionary?,
                                          otherImages: [NSDictionary]?,
                                          completionHandler: @escaping (NSDictionary?, NSError?, NSNumber) -> ()) {
        
        AF.upload(multipartFormData: { multipartFormData in
            
            // Attach image data
            if let otherImages = otherImages, otherImages.count > 0 {
                let dictImgInfo = otherImages[0]
                if let key = dictImgInfo["ImgKey"] as? String,
                   let image = dictImgInfo["ImgData"] as? UIImage,
                let imgData = image.jpegData(compressionQuality: 0.5) {
                       multipartFormData.append(imgData, withName: key, fileName: "\(key).jpeg", mimeType: "image/jpeg")
                   }
            }
            
            // Attach parameters
            if let contentDict = parameters {
                for (key, value) in contentDict {
                    let valueString = String(describing: value)
                    if let data = valueString.data(using: .utf8),
                       let keyString = key as? String {
                        multipartFormData.append(data, withName: keyString)
                    }
                }
            }
        }, to: url, method: .post, headers: nil)
        .responseJSON { response in
            guard let data = response.data else {
                completionHandler(nil, response.error as NSError?, 0)
                return
            }
            
            let returnString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            print("Response: \(returnString ?? "")")
            
            switch response.result {
            case .success(let value):
                if let dictResponse = value as? NSDictionary,
                   let status = dictResponse["status"] as? Int {
                    completionHandler(dictResponse, nil, NSNumber(value: status == 200 ? 200 : 0))
                } else {
                    completionHandler(nil, nil, 0)
                }
            case .failure(let error):
                print("Upload failed: \(error)")
                completionHandler(nil, error as NSError, 0)
            }
        }
    }
}
