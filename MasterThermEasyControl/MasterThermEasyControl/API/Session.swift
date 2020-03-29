//
//  Session.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 20/05/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit
import Bond
import CocoaLumberjack

enum ApiResult {
    case success
    case unauthorized
    case expired
    case connectionError
}

class Session {
    static let ACCOUNT_USER_DEFAULTS_KEY = "account"
    static let SHARED_APP_GROUP_KEY = "group.masterthermeasycontrol"
    
    static let shared = Session()
    
    let apiManager = ApiManager()
    
    var loginResponse: LoginResponse? = nil
    
    private init() {
        
    }
    
    func login(user: String, password:String, completion:@escaping (ApiResult)->()) {
        DDLogInfo("Session.login \(user)")
        apiManager.login(userName: user, password: password) { (loginResponse, error) in
            if let error = error {
                DDLogInfo("Session.login error \(error)")
                completion(.connectionError)
            } else if let loginResponse = loginResponse {
                if loginResponse.returncode == 1 {
                    DDLogInfo("Session.login error response code: \(loginResponse.returncode)")
                    self.clearCredentials()
                    completion(.unauthorized)
                } else {
                    DDLogInfo("Session.login success")
                    self.storeCredentials(user: user, password: password)
                    self.loginResponse = loginResponse
                    completion(.success)
                }
            }
        }
    }
    
    func relogin(completion:@escaping (ApiResult)->()) {
        DDLogInfo("Session.relogin")
        if let account = UserDefaults.init(suiteName: Session.SHARED_APP_GROUP_KEY)?.string(forKey: Session.ACCOUNT_USER_DEFAULTS_KEY) {
            let keychainPasswordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: account,accessGroup: KeychainConfiguration.accessGroup)
            DDLogInfo("Session.relogin has credentials")
            if let password = try? keychainPasswordItem.readPassword() {
                self.login(user: account, password: password, completion: completion)
            } else {
                DDLogInfo("Session.relogin unable to read password")
                completion(.unauthorized)
            }
        } else {
            DDLogInfo("Session.relogin no stored credentials")
            completion(.unauthorized)
        }
    }
    
    func loadData(completion:@escaping (DataResponse?,ModuleInfoResponse?, ApiResult)->()) {
        ApiManager.sharedInstance.getModuleInfo(moduleId: loginResponse?.modules.first?.id ?? "", completion: { (dataResponse, error) in
            if let _ = error {
                completion(nil,nil,.connectionError)
            } else if let moduleResponse = dataResponse {
                ApiManager.sharedInstance.getData(moduleId: self.loginResponse?.modules.first?.id ?? "", completion: { (dataResponse, error) in
                    if let _ = error {
                        completion(nil,nil,.connectionError)
                    } else if let dataResponse = dataResponse {
                        completion(dataResponse,moduleResponse,.success)
                    } else {
                        completion(nil,nil,.expired)
                    }
                })
            } else {
                completion(nil,nil,.expired)
            }
        })
        
    }
    
    func setData(parameter:String, value:String, completion:@escaping (DataResponse?,ApiResult)->()) {
        ApiManager.sharedInstance.setData(moduleId: loginResponse?.modules.first?.id ?? "", parameter: parameter,value: value, completion: { (dataResponse, error) in
            if let _ = error {
                completion(nil,.connectionError)
            } else if let dataResponse = dataResponse {
                completion(dataResponse,.success)
            } else {
                completion(nil,.expired)
            }
        })
    }
    
    
    func storeCredentials(user: String, password:String) {
        clearCredentials()
        loginResponse = nil
        UserDefaults.init(suiteName: Session.SHARED_APP_GROUP_KEY)?.set(user,forKey: Session.ACCOUNT_USER_DEFAULTS_KEY)
        let keychainPasswordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: user,accessGroup: KeychainConfiguration.accessGroup)
        try? keychainPasswordItem.savePassword(password)
    }
    
    func clearCredentials() {
        if let account = UserDefaults.init(suiteName: Session.SHARED_APP_GROUP_KEY)?.string(forKey: Session.ACCOUNT_USER_DEFAULTS_KEY) {
            let keychainPasswordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: account,accessGroup: KeychainConfiguration.accessGroup)
            try? keychainPasswordItem.deleteItem()
        }
        UserDefaults.standard.removeObject(forKey: Session.ACCOUNT_USER_DEFAULTS_KEY)
    }
}
