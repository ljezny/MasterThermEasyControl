//
//  Session.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 20/05/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit
import Bond

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
    
    private var loginResponse: LoginResponse? = nil
    
    private init() {
        
    }
    
    func login(user: String, password:String, completion:@escaping (ApiResult)->()) {
        apiManager.login(userName: user, password: password) { (loginResponse, error) in
            if let _ = error {
                completion(.connectionError)
            } else if let loginResponse = loginResponse {
                if loginResponse.returncode == 1 {
                    self.clearCredentials()
                    completion(.unauthorized)
                } else {
                    self.loginResponse = loginResponse
                    self.storeCredentials(user: user, password: password)
                    completion(.success)
                }
            }
        }
    }
    
    func relogin(completion:@escaping (ApiResult)->()) {
        if let account = UserDefaults.init(suiteName: Session.SHARED_APP_GROUP_KEY)?.string(forKey: Session.ACCOUNT_USER_DEFAULTS_KEY) {
            let keychainPasswordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: account,accessGroup: KeychainConfiguration.accessGroup)
            if let password = try? keychainPasswordItem.readPassword() {
                self.login(user: account, password: password, completion: completion)
            } else {
                completion(.unauthorized)
            }
        } else {
            completion(.unauthorized)
        }
    }
    
    func loadData(completion:@escaping (DataResponse?,ApiResult)->()) {
        ApiManager.sharedInstance.getData(moduleId: loginResponse?.modules.first?.id ?? "", completion: { (dataResponse, error) in
            if let _ = error {
                completion(nil,.connectionError)
            } else if let dataResponse = dataResponse {
                completion(dataResponse,.success)
            }
        })
    }
    
    func storeCredentials(user: String, password:String) {
        clearCredentials()
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
