//
//  LoginClient.swift
//  Prevent Fire
//
//  Created by Shantaram Kokate on 9/17/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import Foundation

class LoginClient: Requestable {
    
    static func signUp(loginRouter: LoginRouter, successCompletion: @escaping (SignUpBase) -> Void, failureCompletion: @escaping (General) -> Void) {
        
        _ = performRequest(route: loginRouter, successCompletion: { (response) in
            
            successCompletion(response)
            
        }, failureCompletion: { (error) in
            
            failureCompletion(error)
        })
        
    }
    
    static func forgotPassword(loginRouter: LoginRouter, successCompletion: @escaping (General) -> Void, failureCompletion: @escaping (General) -> Void) {
        
        _ = performRequest(route: loginRouter, successCompletion: { (response) in
            
            successCompletion(response)
            
        }, failureCompletion: { (error) in
            
            failureCompletion(error)
        })
        
    }
    
    static func login(loginRouter: LoginRouter, successCompletion: @escaping (LoginBase) -> Void, failureCompletion: @escaping (General) -> Void) {
        
        _ = performRequest(route: loginRouter, successCompletion: { (response) in
            
            successCompletion(response)
            
        }, failureCompletion: { (error) in
            failureCompletion(error)
        })
        
    }
    
    static func logout(loginRouter: LoginRouter, successCompletion: @escaping (General) -> Void, failureCompletion: @escaping (General) -> Void) {
        
        _ = performRequest(route: loginRouter, successCompletion: { (response) in
            
            successCompletion(response)
            
        }, failureCompletion: { (error) in
            
            failureCompletion(error)
        })
    }

    static func facebookLogin(loginRouter: LoginRouter, successCompletion: @escaping (SignUp) -> Void, failureCompletion: @escaping (General) -> Void) {
        
        _ = performRequest(route: loginRouter, successCompletion: { (response) in
            
            successCompletion(response)
            
        }, failureCompletion: { (response) in
            
            failureCompletion(response)
        })
    }
    
    static func uploadRegistrationImage(loginRouter: LoginRouter, successCompletion: @escaping (SignUp) -> Void, failureCompletion: @escaping (General) -> Void) {
    }
    
    static func countryList(loginRouter: LoginRouter, successCompletion: @escaping ([CountryListBase]) -> Void, failureCompletion: @escaping (String) -> Void) {
        
        /*
        _ = performRequest(route: loginRouter, successCompletion: { (response) in
            
            successCompletion(response)
            
        }, failureCompletion: { (error) in
            
            failureCompletion(error)
        }) */
        
        let url = URL(string: "https://gist.githubusercontent.com/Goles/3196253/raw/9ca4e7e62ea5ad935bb3580dc0a07d9df033b451/CountryCodes.json")
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        let task = session.dataTask(with: url!){
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                print(response)
                if error == nil {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let object = try jsonDecoder.decode([CountryListBase].self, from: data!)
                        successCompletion(object)
                    } catch {
                        failureCompletion("error")
                    }
                    
                } else {
                    failureCompletion("error")
                }
            }
         }
        task.resume()
        
    }
    
}
