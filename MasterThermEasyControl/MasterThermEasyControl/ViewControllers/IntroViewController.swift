//
//  IntroViewController.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 27/05/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet weak var gradientView: GradientView!
    override func viewDidLoad() {
        super.viewDidLoad()

        gradientView.progress.value = 0.4
    }

}
