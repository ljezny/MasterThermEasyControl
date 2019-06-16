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
            self.setTitleColor(UIColor.white, for: .normal)
            self.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .disabled)
            self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            self.layer.borderColor = UIColor.white.cgColor
            self.layer.borderWidth = 1.0
            break
        default:
            break
        }
    }
    
}
