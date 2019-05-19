//
//  LoginResponse.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 19/05/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit
import HandyJSON

class LoginResponse: HandyJSON {
    
    var returncode = -1
    var modules = [ModuleResponse]()
    
    required init() {
        
    }
}

class ModuleResponse: HandyJSON {
    
    var id = ""
    var module_name = ""
    required init() {
        
    }
}
