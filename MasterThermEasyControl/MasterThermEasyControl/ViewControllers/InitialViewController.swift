//
//  InitialViewController.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 15/06/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit

class InitialViewController: BaseViewController {

    @IBOutlet weak var appNameLabel: StyleableLabel!
    @IBOutlet weak var logoStack: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
            
        let attributedString = NSMutableAttributedString(string: "MasterTherm\rEasy Control", attributes: [
            .font: Theme.getRegularFont(size: 30),
            //.foregroundColor: UIColor(white: 0.0, alpha: 1.0),
            .kern: 1.05
            ])
        attributedString.addAttributes([
            .font: Theme.getLightFont(size: 30),
            .kern: 1.5
            ], range: NSRange(location: 0, length: 11))
        appNameLabel.attributedText = attributedString
        
        self.logoStack.alpha = 0.0
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3) {
            self.logoStack.alpha = 1.0
        }
    }
}
