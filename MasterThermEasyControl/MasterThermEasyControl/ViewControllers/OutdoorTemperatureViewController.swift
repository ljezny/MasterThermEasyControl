//
//  OutdoorTemperatureViewController.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 11/10/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit
import Bond

class OutdoorTemperatureViewController: UIViewController {

    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var outsideTempLabel: StyleableLabel!
    
    var model: HeatPumpModel? = nil {
        didSet {
            //setup bindings
            let _ = self.view
            
            model?.outsideTemperature.map({ (d) -> String? in
                return NumberFormatUtils.formatTemperature(value: d)
            }).bind(to: outsideTempLabel.reactive.text).dispose(in: self.bag)
            model?.outsideTemperature.observeNext(with: { (d) in
                if let d = d {
                    self.gradientView.progress.value = (d + 20.0) / (20.0 + 40.0)
                }
            }).dispose(in: self.bag)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
