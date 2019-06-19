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
    
    override func updateFromData(response: DataResponse) {
        outsideTemperature.value = response.getAnalog(id: 3)
        realHeatWaterTemperature.value = response.getAnalog(id: 1)
        requestedHeatWaterTemperature.value = response.getAnalog(id: 5)
    }
}
