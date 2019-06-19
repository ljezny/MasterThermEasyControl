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
