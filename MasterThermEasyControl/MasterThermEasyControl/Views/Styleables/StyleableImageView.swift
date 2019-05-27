//
//  StyleableImageView.swift
//  Equimo.iOS
//
//  Created by David Blažek on 27/08/2018.
//  Copyright © 2018 Lukas Jezny. All rights reserved.
//

import UIKit

@IBDesignable class StyleableImageView: UIImageView {

    @IBInspectable var style: String?{
        didSet{
            setStyle(style: self.style)
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
           // self.tintColor = Theme.tintColor
            break
        default:
            break
        }
    }
}
