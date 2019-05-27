//
//  StyleableButton.swift
//  Equimo.iOS
//
//  Created by Lukas Jezny on 22/01/2018.
//  Copyright © 2018 David Blazek. All rights reserved.
//

import UIKit

@IBDesignable class StyleableButton: UIButton {

    @IBInspectable var style: String?{
        didSet{
            setStyle(style: self.style)
        }
    }
    
    @IBInspectable var localizedKey: String?{
        didSet{
            self.setTitle(NSLocalizedString(self.localizedKey!, comment: ""), for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func setStyle(style:String?) -> Void {
        switch style! {
        case "primary":
            //self.backgroundColor = Theme.tintColor
            self.layer.cornerRadius = 5
            //self.setTitleColor(Theme.semiDarkBackgroundColor, for: .normal)
            //self.setTitleColor(Theme.darkBackgroundColor, for: .disabled)
            //self.titleLabel?.font = Theme.getRegularFont(size: Theme.largeFontSize)
            break
        default:
            break
        }
    }
    
}
