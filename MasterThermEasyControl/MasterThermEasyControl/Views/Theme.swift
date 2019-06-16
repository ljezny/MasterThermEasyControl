//
//  Theme.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 16/06/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit

class Theme {
    public static func getLightFont(size: CGFloat) -> UIFont? {
        return UIFont(name: "SF-Pro-Display-Thin", size: size)
    }
    
    public static func getRegularFont(size: CGFloat) ->UIFont? {
        return UIFont(name: "SF-Pro-Display-Medium", size: size)
    }
}
