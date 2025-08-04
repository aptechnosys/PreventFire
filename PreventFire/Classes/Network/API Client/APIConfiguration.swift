//
//  APIConfiguration.swift
//  Prevent Fire
//
//  Created by Shantaram Kokate on 9/17/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var requestType: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

extension APIConfiguration {
    func asURLRequest() throws -> URLRequest {
        let baseURL = APPURL.baseUrl()
        let url =  String(format: "%@%@", baseURL, path)
        let urlwithPercent = url.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        var urlRequest = URLRequest(url: URL(string: urlwithPercent!)!)
        // Http method
        urlRequest.httpMethod = requestType.rawValue
        //common headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(acceptLangauge, forHTTPHeaderField: HTTPHeaderField.acceptLangauge.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        let apiSessionKey = "SK"
            let sessionKey = "Bearer " + apiSessionKey
            print(sessionKey)
            urlRequest.setValue( sessionKey, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
    
    var acceptLangauge: String {
        return "en"
    }
}
