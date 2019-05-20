//
//  DataResponse.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 19/05/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit
import HandyJSON

class DataError: HandyJSON {
    var errorId = 0
    var errorMessage = ""
    
    required init() {
        
    }
}

class DataResponse: HandyJSON {
    
    var variables = Dictionary<String,String>()
    var error = DataError()
    
    required init() {
        
    }
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.variables <-- "data.varfile_mt1_config1.001"
    }
    
    func getDigital(id:Int) -> Bool? {
        if let v = variables["D_\(id)"] {
            return NSString(string: v).boolValue
        }
        return nil
    }
    
    func getInteger(id:Int) -> Int? {
        if let v = variables["I_\(id)"] {
            return Int(NSString(string: v).intValue)
        }
        return nil
    }
    
    func getAnalog(id:Int) -> Double? {
        if let v = variables["A_\(id)"] {
            return NSString(string: v).doubleValue
        }
        return nil
    }
}
