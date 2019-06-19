//
//  ModelBase.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 19/06/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit

class ModelBase {
    var name:String? {
        return nil
    }
    
    var icon:String? {
        return nil
    }
    
    func updateFromData(response: DataResponse) {
    }
    
    func getUpdatedValues() -> [String:String] {
        var result = [String:String]()
        return result
    }
}
