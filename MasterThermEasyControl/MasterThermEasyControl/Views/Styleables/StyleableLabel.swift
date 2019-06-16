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
    
    @IBInspectable var circularCornerRadius: Bool = false {
        didSet{
            updateCornerRadius()
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
            self.font = UIFont.systemFont(ofSize: 20, weight: .regular)
            self.textColor = UIColor.white
            break
        case "body":
            self.font = Theme.getL
            self.textColor = UIColor.white
            break
        case "subtitle":
            //self.font = Theme.getRegularFont(size: Theme.smallFontSize)
            self.textColor = UIColor.white
            break
        default:
            break
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
    }
    
    func updateCornerRadius() {
        if self.circularCornerRadius == true {
            self.layer.cornerRadius = min(self.bounds.width,self.bounds.height) / 2.0
        }
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
