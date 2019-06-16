//
//  HotWater.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 15/06/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit

class HotWaterModel:TemperatureModelBase {
    override func updateFromData(response: DataResponse) -> TemperatureModelBase {
        realTemperature.value = response.getAnalog(id: 126)
        setTemperature.value = response.getAnalog(id: 129)
        minSetTemperature.value = response.getAnalog(id: 296)
        maxSetTemperature.value = response.getAnalog(id: 297)
        
        return self
    }
    
    override var name: String? {
        return NSLocalizedString("hotwatermodel.name", comment: "")
    }
    
    override var icon: String? {
        return "ic_water"
    }
}
