//
//  HeatPumpInfoViewController.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 17/06/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit

class HeatPumpInfoViewController: PageBaseViewController {

    @IBOutlet weak var outsideTempLabel: StyleableLabel!
    
    @IBOutlet weak var setTempLabel: StyleableLabel!
    @IBOutlet weak var realTempLabel: StyleableLabel!
    
    var model: HeatPumpModel? = nil {
        didSet {
            //setup bindings
            let _ = self.view
            
            model?.outsideTemperature.map({ (d) -> String? in
                if let d = d {
                    return String(format: "%.1f °C", d)
                }
                return "--,- °C"
            }).bind(to: outsideTempLabel.reactive.text).dispose(in: self.bag)
            model?.requestedHeatWaterTemperature.map({ (d) -> String? in
                if let d = d {
                    return String(format: "%.1f °C", d)
                }
                return "--,- °C"
            }).bind(to: setTempLabel.reactive.text).dispose(in: self.bag)
            model?.realHeatWaterTemperature.map({ (d) -> String? in
                if let d = d {
                    return String(format: "%.1f °C", d)
                }
                return "--,- °C"
            }).bind(to: realTempLabel.reactive.text).dispose(in: self.bag)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
