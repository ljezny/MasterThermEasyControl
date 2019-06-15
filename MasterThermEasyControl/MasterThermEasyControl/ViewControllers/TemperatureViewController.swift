//
//  TemperatureViewController.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 16/05/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit
import Bond

class TemperatureViewController: UIViewController {
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var knob: Knob!
    @IBOutlet weak var setTemperatureLabel: UILabel!
    @IBOutlet weak var realTemperatureLabel: UILabel!
    
    var model: TemperatureModelBase? = nil {
        didSet {
            //setup bindings
            let _ = self.view
            
            model?.setTemperature.map({ (d) -> String? in
                if let d = d {
                    return String(format: "%.1f", d)
                }
                return "--"
            }).bind(to: setTemperatureLabel.reactive.text).dispose(in: self.bag)
            model?.realTemperature.map({ (d) -> String? in
                if let d = d {
                    return String(format: "%.1f", d)
                }
                return "--"
            }).bind(to: realTemperatureLabel.reactive.text).dispose(in: self.bag)
            
            self.knob.minimumValue = model?.minSetTemperature.value ?? 0.0
            self.knob.maximumValue = model?.maxSetTemperature.value ?? 1.0
            model?.setTemperature.bidirectionalBind(to: self.knob.value).dispose(in: self.bag)
            self.knob.setValue(model?.setTemperature.value ?? 0.0, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.knob.value.observeNext {[weak self] (v) in
            self?.updateGradient(v: v ?? 0.0)
            }.dispose(in: self.bag)

    }
    
    func updateGradient(v: Double) {
        self.gradientView.progress.value = v / (self.knob.maximumValue - self.knob.minimumValue)
    }
}
