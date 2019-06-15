//
//  GradientView.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 25/05/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit
import Bond
@IBDesignable class GradientView: UIView {

    let gl = CAGradientLayer()
    
    let progress = Observable<Double>(0.0)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        
        progress.observeNext {[weak self] (f) in
            let offset = Float(5.0 * (1.0 - f))
            self?.gl.locations = [
                0.0 - offset,
                2.0 - offset,
                4.0 - offset,
                6.0 - offset
                ] as [NSNumber]
        }.dispose(in: self.bag)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func setup() {
        gl.colors = [ UIColor.red.cgColor, UIColor.orange.cgColor,UIColor.magenta.cgColor, UIColor.blue.cgColor]
        gl.locations = [ 0.0, 0.0, 0.0, 1.0]
        self.layer.addSublayer(gl)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gl.frame = self.bounds
    }
    
}
