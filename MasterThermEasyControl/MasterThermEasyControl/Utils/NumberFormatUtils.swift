//
//  NumberFormatUtils.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 21/06/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit

class NumberFormatUtils: NSObject {
    static func formatTemperature(value:Double?) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.minimumFractionDigits = 1
        
        if let value = value {
            return "\(numberFormatter.string(for: value) ?? "") °C"
        }
        
        return "--\(numberFormatter.decimalSeparator ?? "")- °C"
    }
}
