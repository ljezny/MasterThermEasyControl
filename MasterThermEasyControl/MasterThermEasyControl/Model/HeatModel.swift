//
//  HeatModel.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 20/05/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit

class HeatModel : TemperatureModelBase {
    /*let real_temp_param_id:Int
    let has_real_temp_param_id:Int
    let approximated_real_temp_param_id:Int
    let set_temp_param_id:Int
    let hw_set_temp_param_id:Int
    let hw_real_temp_param_id:Int
    let is_on_param_id:Int
    
    init(real_temp_param_id:Int,has_real_temp_param_id:Int,approximated_real_temp_param_id:Int,set_temp_param_id:Int,hw_set_temp_param_id:Int,hw_real_temp_param_id:Int,is_on_param_id:Int) {
        self.real_temp_param_id = real_temp_param_id
        self.has_real_temp_param_id = has_real_temp_param_id
        self.approximated_real_temp_param_id = approximated_real_temp_param_id
        self.set_temp_param_id = set_temp_param_id
        self.hw_set_temp_param_id = hw_set_temp_param_id
        self.hw_real_temp_param_id = hw_real_temp_param_id
        self.is_on_param_id = is_on_param_id
    }*/
    
    override var name: String? {
        return NSLocalizedString("heatmodel.name", comment: "")
    }
    
    override var icon: String? {
        return "ic_home"
    }
    
    override func updateFromData(response: DataResponse) -> TemperatureModelBase {
        realTemperature.value = response.getAnalog(id: 211)
        setTemperature.value = response.getAnalog(id: 191)
        minSetTemperature.value = 10.0//response.getAnalog(id: 296)
        maxSetTemperature.value = 40.0//response.getAnalog(id: 297)
        
        return self
    }
}
