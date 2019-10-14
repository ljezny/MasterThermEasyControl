//
//  HeatPumpModel.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 19/06/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit
import Bond

class HeatPumpModel: ModelBase {
    let outsideTemperature = Observable<Double?>(nil)
    let realHeatWaterTemperature = Observable<Double?>(nil)
    let requestedHeatWaterTemperature = Observable<Double?>(nil)
    let owner = Observable<String?>(nil)
    let city = Observable<String?>(nil)
    let company = Observable<String?>(nil)
    
    init(moduleInfo: String?) {
        if let components = moduleInfo?.components(separatedBy: "_"), components.count >= 6 {
            self.owner.value = components[2]
            self.city.value = components[3]
            self.company.value = components[5]
        }
        
    }
    
    override func updateFromData(response: DataResponse) {
        outsideTemperature.value = response.getAnalog(id: 3)
        realHeatWaterTemperature.value = response.getAnalog(id: 1)
        requestedHeatWaterTemperature.value = response.getAnalog(id: 5)
    }
}
