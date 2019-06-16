//
//  StyleableTextField.swift
//  Equimo.iOS
//
//  Created by David Blažek on 16/01/2018.
//  Copyright © 2018 David Blazek. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class StyleableTextField: UITextField {
    
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
    
    
    @IBInspectable var localizedPlaceholderKey: String?{
        didSet{
            self.placeholder = NSLocalizedString(self.localizedPlaceholderKey!, comment: "")
        }
    }
    
    /*override var placeholder: String? {
        didSet {
            if let text = self.placeholder {
                self.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedStringKey.foregroundColor: Theme.grayColor, NSAttributedStringKey.font : Theme.getLightFont(size: Theme.normalFontSize)])
            }
        }
    }*/
    
    let bottomLine = CALayer()
    
    func setStyle(style:String?) -> Void {
        switch style! {
        case "primary":
            bottomLine.backgroundColor = UIColor.white.cgColor
            self.layer.addSublayer(bottomLine)
            self.borderStyle = .none
            self.textAlignment = .center
            self.backgroundColor = UIColor.clear
            self.font = Theme.getRegularFont(size: 16)
            
            break
        default:
            break
        }
        
        self.keyboardAppearance = .dark
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        if style == "primary" {
            let adjust: CGFloat = 14.0
            return CGRect(x: bounds.origin.x, y: bounds.origin.y + adjust/2, width: bounds.size.width, height: bounds.size.height - adjust)
        }
        return bounds
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bottomLine.frame = CGRect(origin: CGPoint(x: 0, y:self.frame.height - 1), size: CGSize(width: self.frame.width, height:  1))
    }
}
