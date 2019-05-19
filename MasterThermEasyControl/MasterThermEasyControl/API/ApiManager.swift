//
//  ApiManager.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 19/05/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit
import HandyJSON

class ApiManager: NSObject {
    static let sharedInstance = ApiManager()
    
    let session = URLSession.shared
    
    static let BASE_URL = "https://mastertherm.vip-it.cz/plugins"
    
    public func login(userName:String, password:String, completion: @escaping (LoginResponse?,Error?)->()) {
        let urlString = URL(string: ApiManager.BASE_URL)
        if let baseUrl = urlString {
            let loginURL = baseUrl.appendingPathComponent("mastertherm_login/client_login.php")
            var request = URLRequest(url: loginURL)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            let parameters: [String: Any] = [
                "login": "login",
                "uname": userName,
                "upwd" : password.sha1()
            ]
            request.httpBody = parameters.percentEscaped().data(using: .utf8)
            
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(nil,error)
                    }
                } else {
                    if let responseData = data,let responseString = String.init(data: responseData, encoding: .utf8),let response = LoginResponse.deserialize(from: responseString) {
                        completion(response,nil)
                    }
                }
            }
            task.resume()
        }
    }
}
