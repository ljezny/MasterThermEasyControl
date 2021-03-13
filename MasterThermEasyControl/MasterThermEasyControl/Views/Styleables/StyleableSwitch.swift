//
//  StyleableSwitch.swift
//  Equimo.iOS
//
//  Created by David Blažek on 27/08/2018.
//  Copyright © 2018 Lukas Jezny. All rights reserved.
//

import UIKit

@IBDesignable class StyleableSwitch: UISwitch {

    @IBInspectable var switchStyle: String?{
        didSet{
            setStyle(style: self.switchStyle)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setStyle(style: String?) -> Void {
        switch switchStyle! {
        case "tint":
            //self.onTintColor = Theme.tintColor                  // ON state
            //self.backgroundColor = Theme.darkBackgroundColor    // background
            //self.tintColor = Theme.whiteColor                   // outline when off
            break
        default:
            break
        }
    }
}
