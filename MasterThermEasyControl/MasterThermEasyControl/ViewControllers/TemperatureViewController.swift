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
    
   // let model: TemperatureModelBase
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.knob.value.observeNext {[weak self] (v) in
            self?.gradientView.progress.value = v
        }.dispose(in: self.bag)
       
    }
}
