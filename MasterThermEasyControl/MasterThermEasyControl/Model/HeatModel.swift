//
//  HeatModel.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 20/05/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit
import Bond

class HeatModel : TemperatureModelBase {
    let set_temp_condition_param_id:Int
    let set_primary_temp_param_id:Int
    let set_secondary_temp_param_id:Int
    let real_temp_param_id:Int
    let hw_set_temp_param_id:Int
    let hw_real_temp_param_id:Int
    let is_on_param_id:Int?
    let pad_name_begin_id:Int?
    let pad:String
    let is_enabled_param_id:Int?
    
    let hwRealTemperature = Observable<Double?>(nil)
    let hwSetTemperature = Observable<Double?>(nil)
    let defaultName: String
    
    var customName: String? = nil
    
    private var set_temp_param_id: Int = -1
    init(set_temp_condition_param_id:Int,set_primary_temp_param_id:Int,set_secondary_temp_param_id:Int,real_temp_param_id:Int,hw_set_temp_param_id:Int,hw_real_temp_param_id:Int,is_on_param_id:Int?, pad_name_begin_id:Int?, pad:String, is_enabled_param_id: Int?, defaultName: String) {
        self.set_primary_temp_param_id = set_primary_temp_param_id
        self.set_temp_condition_param_id = set_temp_condition_param_id
        self.set_secondary_temp_param_id = set_secondary_temp_param_id
        self.real_temp_param_id = real_temp_param_id
        self.hw_set_temp_param_id = hw_set_temp_param_id
        self.hw_real_temp_param_id = hw_real_temp_param_id
        self.is_on_param_id = is_on_param_id
        self.pad = pad
        self.pad_name_begin_id = pad_name_begin_id
        self.is_enabled_param_id = is_enabled_param_id
        self.defaultName = defaultName
    }
    
    override var name: String? {
        return customName ?? defaultName
    }
    
    override var icon: String? {
        return "ic_home"
    }
    
    override func updateFromData(response: DataResponse) {
        set_temp_param_id = (response.getDigital(id: set_temp_condition_param_id) ?? false) ? set_primary_temp_param_id : set_secondary_temp_param_id
        
        realTemperature.value = response.getAnalog(id: real_temp_param_id)
        if let newValue = response.getAnalog(id: set_temp_param_id), setTemperature.value != newValue {
            setTemperature.value = newValue
        }
        minSetTemperature.value = 10.0
        maxSetTemperature.value = 40.0
        
        hwSetTemperature.value = response.getAnalog(id: hw_set_temp_param_id)
        hwRealTemperature.value = response.getAnalog(id: hw_real_temp_param_id)
        
        if let is_on_param_id = self.is_on_param_id {
            isOn.value = response.getDigital(id: is_on_param_id) ?? false
        }
        
        if let is_enabled_param_id = self.is_enabled_param_id {
            isEnabled.value = pad != "0" && (response.getDigital(id: is_enabled_param_id) ?? false)
        } else {
            isEnabled.value = pad != "0"
        }
        
        updateCustomName(response: response)
    }
    
    override func getUpdatedValues() -> [String : String] {
        var result = super.getUpdatedValues()
        
        result["A_\(set_temp_param_id)"] = String(format: "%.1f", setTemperature.value ?? 0.0)
        return result
    }
    
    func updateCustomName(response: DataResponse) {
        customName = nil
        if let start_index = self.pad_name_begin_id {
            let alphabet = "-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            var name = ""
            for i in 0..<7 {
                let v = response.getInteger(id: start_index + i) ?? 0
                if v > 0 && v < 36 {
                    let index = alphabet.index(alphabet.startIndex, offsetBy: v)
                    name.append(alphabet[index])
                }
            }
            if !name.isEmpty {
                customName = name
            }
        }
        
        
    }
}
