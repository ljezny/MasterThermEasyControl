//
//  DataResponse.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 19/05/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit
import HandyJSON

class Variables {
    var I_418 = ""
}

class DataResponse: HandyJSON {
    
    var returncode = -1
    var variables = Variables()
    
    required init() {
        
    }
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.variables <-- "data.varfile_mt1_config1.001"
    }
}
