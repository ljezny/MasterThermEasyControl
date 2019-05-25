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
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.slider.reactive.value.bind(to: gradientView.progress).dispose(in: self.bag)
    }
}
