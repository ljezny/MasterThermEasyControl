//
//  TemperatureModelBase.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 15/06/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit
import Bond

class TemperatureModelBase: ModelBase {
    let realTemperature = Observable<Double?>(nil)
    let setTemperature = Observable<Double?>(nil)
    let minSetTemperature = Observable<Double?>(nil)
    let maxSetTemperature = Observable<Double?>(nil)
    let isOn = Observable<Bool>(true)
    let isEnabled = Observable<Bool>(false)
    
    static func createListFromData(response: DataResponse, moduleResponse: ModuleInfoResponse) -> [TemperatureModelBase] {
        var result = [TemperatureModelBase]()
        result.append(HeatModel(set_temp_condition_param_id: 245, set_primary_temp_param_id: 219, set_secondary_temp_param_id: 215, real_temp_param_id: 216, hw_set_temp_param_id: 96, hw_real_temp_param_id: 90, is_on_param_id: 212, pad_name_begin_id: 211, pad: moduleResponse.pada, is_enabled_param_id: 278, defaultName: "Pad A"))
        result.append(HeatModel(set_temp_condition_param_id: 248, set_primary_temp_param_id: 225, set_secondary_temp_param_id: 221, real_temp_param_id: 222, hw_set_temp_param_id: 97, hw_real_temp_param_id: 91, is_on_param_id: 216, pad_name_begin_id: 221, pad: moduleResponse.padb, is_enabled_param_id: 436, defaultName: "Pad B"))
        result.append(HeatModel(set_temp_condition_param_id: 251, set_primary_temp_param_id: 231, set_secondary_temp_param_id: 227, real_temp_param_id: 228, hw_set_temp_param_id: 98, hw_real_temp_param_id: 92, is_on_param_id: 220, pad_name_begin_id: 231, pad: moduleResponse.padc, is_enabled_param_id: 298, defaultName: "Pad C"))
        result.append(HeatModel(set_temp_condition_param_id: 254, set_primary_temp_param_id: 238, set_secondary_temp_param_id: 233, real_temp_param_id: 234, hw_set_temp_param_id: 99, hw_real_temp_param_id: 93, is_on_param_id: 50, pad_name_begin_id: 241, pad: moduleResponse.padd, is_enabled_param_id: 307, defaultName: "Pad D"))
        result.append(HeatModel(set_temp_condition_param_id: 257, set_primary_temp_param_id: 247, set_secondary_temp_param_id: 240, real_temp_param_id: 241, hw_set_temp_param_id: 243, hw_real_temp_param_id: 242, is_on_param_id: 51, pad_name_begin_id: 251, pad: moduleResponse.pade, is_enabled_param_id: 316, defaultName: "Pad E"))
        result.append(HeatModel(set_temp_condition_param_id: 259, set_primary_temp_param_id: 277, set_secondary_temp_param_id: 249, real_temp_param_id: 250, hw_set_temp_param_id: 252, hw_real_temp_param_id: 251, is_on_param_id: 52, pad_name_begin_id: 261, pad: moduleResponse.padf, is_enabled_param_id: 326, defaultName: "Pad F"))
        result.append(HeatModel(set_temp_condition_param_id: 242, set_primary_temp_param_id: 191, set_secondary_temp_param_id: 210, real_temp_param_id: 211, hw_set_temp_param_id: 5, hw_real_temp_param_id: 1, is_on_param_id: nil, pad_name_begin_id: nil, pad: moduleResponse.padz, is_enabled_param_id: nil, defaultName: NSLocalizedString("heatmodel.name", comment: "")))
        
        result.append(HotWaterModel())
        
        result.forEach { (m) in
            m.updateFromData(response: response)
        }
        //return result
        
        return result.filter({ (v) -> Bool in
            v.isEnabled.value
        })
    }
}
