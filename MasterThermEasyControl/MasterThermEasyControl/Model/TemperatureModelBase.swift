//
//  TemperatureModelBase.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 15/06/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit
import Bond

class TemperatureModelBase {
    var name:String? {
        return nil
    }
    
    var icon:String? {
        return nil
    }
    
    let realTemperature = Observable<Double?>(nil)
    let setTemperature = Observable<Double?>(nil)
    let minSetTemperature = Observable<Double?>(nil)
    let maxSetTemperature = Observable<Double?>(nil)
    
    func updateFromData(response: DataResponse) -> TemperatureModelBase {
        return self
    }
    
    func getUpdatedValues() -> [String:String] {
        var result = [String:String]()
        return result
    }
    
    static func createListFromData(response: DataResponse) -> [TemperatureModelBase] {
        var result = [TemperatureModelBase]()
        
        result.append(HeatModel())
        result.append(HotWaterModel())
        
        result.forEach { (m) in
            m.updateFromData(response: response)
        }
        return result
    }
}
