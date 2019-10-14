//
//  StyleableLabel.swift
//  Equimo.iOS
//
//  Created by David Blažek on 15/01/2018.
//  Copyright © 2018 David Blazek. All rights reserved.
//

import UIKit

@IBDesignable class StyleableLabel: UILabel {

    @IBInspectable var style: String?{
        didSet{
            setStyle(style: self.style)
        }
    }
    
    @IBInspectable var localizedKey: String?{
        didSet{
            self.text = NSLocalizedString(self.localizedKey!, comment: "")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBInspectable var topInset: CGFloat = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat = 0.0
    @IBInspectable var rightInset: CGFloat = 0.0
    
    func setStyle(style:String?) -> Void {
        switch style! {
        case "header":
            self.font = Theme.getRegularFont(size: 20)
            self.textColor = UIColor.white
            break
        case "body":
            self.font = Theme.getLightFont(size: 16.0)
            self.textColor = UIColor.white
            break
        case "bodyInverted":
            self.font = Theme.getLightFont(size: 16.0)
            self.textColor = UIColor.black
            break
        case "caption":
            self.font = Theme.getLightFont(size: 24.0)
            self.textColor = UIColor.white
            break
        case "hugevalue":
            self.font = Theme.getLightFont(size: 36.0)
            self.textColor = UIColor.white
            break
        case "mainvalue":
            self.font = Theme.getRegularFont(size: 36.0)
            self.textColor = UIColor.white
            break
        case "value":
            self.font = Theme.getLightFont(size: 24.0)
            self.textColor = UIColor.white
            break
        case "subvalue":
            self.font = Theme.getLightFont(size: 16.0)
            self.textColor = UIColor.white
            break
        default:
            break
        }
        
        //self.layer.borderColor = UIColor.white.cgColor
        //self.layer.borderWidth = 0.5
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
}
