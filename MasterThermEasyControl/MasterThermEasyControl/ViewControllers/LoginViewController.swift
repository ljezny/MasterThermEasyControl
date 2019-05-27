//
//  LoginViewController.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 27/05/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var gradientView: GradientView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gradientView.progress.value = 0.7
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
