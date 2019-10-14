//
//  UIViewControllerEx.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 11/10/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func isLandscape() ->Bool {
        if let bounds = self.view.window?.bounds {
            return bounds.width > bounds.height
        }
        return false
    }
    
    func isLargeWidthWindow() -> Bool {
        if let bounds = self.view.window?.bounds {
            return bounds.width > 800
        }
        return false
    }
}
