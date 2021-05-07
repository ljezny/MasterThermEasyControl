//
//  ApiManager.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 19/05/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit
import HandyJSON
import CocoaLumberjack

class ApiManager: NSObject {
    static let sharedInstance = ApiManager()
    
    let session = URLSession.shared
    
    static let BASE_URL = "https://mastertherm.vip-it.cz/plugins"
    static let PARAMS_BASE_URL = "https://mastertherm.vip-it.cz/mt"
    
    private var messageId = 1
    
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
            DDLogDebug("login request started: \(parameters.percentEscaped())")
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    DDLogError("login request error: \(error)")
                    DispatchQueue.main.async {
                        completion(nil,error)
                    }
                } else {
                    if let responseData = data,let responseString = String.init(data: responseData, encoding: .utf8) {
                        DDLogDebug("login response: \(responseString)")
                        if let response = LoginResponse.deserialize(from: responseString) {
                            DispatchQueue.main.async {
                                completion(response,nil)
                            }
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    public func getData(moduleId:String, completion: @escaping (DataResponse?,Error?)->()) {
        messageId += 1
        
        let urlString = URL(string: ApiManager.PARAMS_BASE_URL)
        if let baseUrl = urlString {
            let dataUrl = baseUrl.appendingPathComponent("PassiveVizualizationServlet")
            var request = URLRequest(url: dataUrl)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            let parameters: [String: Any] = [
                "messageId": messageId,
                "moduleId": moduleId,
                "fullRange" : "true"
            ]
            request.httpBody = parameters.percentEscaped().data(using: .utf8)
            DDLogDebug("get data request started: \(parameters.percentEscaped())")
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(nil,error)
                    }
                } else {
                    if let responseData = data,let responseString = String.init(data: responseData, encoding: .utf8) {
                        DDLogDebug("get data response: \(responseString)")
                        if let response = DataResponse.deserialize(from: responseString) {
                            DispatchQueue.main.async {
                               completion(response,nil)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(nil,nil)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    public func getModuleInfo(moduleId:String, completion: @escaping (ModuleInfoResponse?,Error?)->()) {
        let urlString = URL(string: ApiManager.BASE_URL)
        if let baseUrl = urlString {
            let dataUrl = baseUrl.appendingPathComponent("get_pumpinfo/get_pumpinfo.php")
            var request = URLRequest(url: dataUrl)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            let parameters: [String: Any] = [
                "moduleid": moduleId,
                "unitid" : "1"
            ]
            request.httpBody = parameters.percentEscaped().data(using: .utf8)
            DDLogDebug("get module request started: \(parameters.percentEscaped())")
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(nil,error)
                    }
                } else {
                    if let responseData = data,let responseString = String.init(data: responseData, encoding: .utf8) {
                        DDLogDebug("get module info response: \(responseString)")
                        if let response = ModuleInfoResponse.deserialize(from: responseString) {
                            DispatchQueue.main.async {
                                completion(response,nil)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(nil,nil)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    public func setData(moduleId:String,parameter:String, value:String, completion: @escaping (DataResponse?,Error?)->()) {
        messageId += 1
        
        let urlString = URL(string: ApiManager.PARAMS_BASE_URL)
        if let baseUrl = urlString {
            let dataUrl = baseUrl.appendingPathComponent("ActiveVizualizationServlet")
            var request = URLRequest(url: dataUrl)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            let parameters: [String: Any] = [
                "messageId": "\(messageId)",
                "moduleId": moduleId,
                "deviceId": "1", //I dont know where to get this value
                "configFile":"varfile_mt1_config",
                "errorResponse":"true",
                "variableId":parameter,
                "variableValue":value
            ]
            request.httpBody = parameters.percentEscaped().data(using: .utf8)
            DDLogDebug("set data request started: \(parameters.percentEscaped())")
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(nil,error)
                    }
                } else {
                    if let responseData = data,let responseString = String.init(data: responseData, encoding: .utf8) {
                        DDLogDebug("set data response: \(responseString)")
                        if let response = DataResponse.deserialize(from: responseString) {
                            DispatchQueue.main.async {
                                completion(response,nil)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(nil,nil)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
