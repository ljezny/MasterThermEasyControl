//
//  MainViewController.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 16/05/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit

class MainViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let temperatureViewController = TemperatureViewController.init(nibName: "TemperatureViewController", bundle: Bundle.main)
        
        setViewControllers([temperatureViewController], direction: UIPageViewController.NavigationDirection.forward, animated: false) { (b) in
            
        }
    }
}
