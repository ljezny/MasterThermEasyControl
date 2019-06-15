//
//  AlertHelper.swift
//  Equimo.iOS
//
//  Created by David Blažek on 15/01/2018.
//  Copyright © 2018 David Blazek. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class AlertUtils {
    
    static func createSimpleAlert(titleKey: String, messageKey: String, confirmKey: String? = nil, cancelKey: String? = nil) -> UIViewController{
        let alert = AlertViewController(nibName: R.nib.alertViewController.name, bundle: nil)
        
        _ = alert.view
        
        alert.secondaryButton.isHidden = true
        alert.primaryButton.isHidden = true
        alert.negativeButton.isHidden = true
        alert.positiveButton.isHidden = true
        
        if let confirmKey = confirmKey {
            alert.primaryButton.isHidden = false
            alert.primaryButton.setTitle(NSLocalizedString(confirmKey,comment: ""), for: .normal)
        }
        if let cancelKey = cancelKey {
            alert.secondaryButton.isHidden = false
            alert.secondaryButton.setTitle(NSLocalizedString(cancelKey,comment: ""), for: .normal)
        }
        return alert
    }
    
    static func createErrorAlert(error: Error) -> UIViewController{
        return createSimpleAlert(title: R.string.localizable.appName(), message: error.localizedDescription)
    }
    
    static func createSimpleAlert(title: String, message: String?, onDismiss: (()->())? = nil) -> UIViewController{
        let alert = AlertViewController(nibName: R.nib.alertViewController.name, bundle: nil)
        
        _ = alert.view
        
        alert.titleLabel.text = title
        alert.bodyLabel.text = message
        
        alert.primaryCompletion = onDismiss
        alert.primaryButton.isHidden = false
        alert.primaryButton.setTitle(R.string.localizable.generalOk(), for: .normal)
        
        alert.secondaryButton.isHidden = true
        alert.negativeButton.isHidden = true
        alert.positiveButton.isHidden = true

        return alert
    }
    
    static func createConfirmAlert(title: String, message: String, confirmAction: @escaping ()->()) -> UIViewController{
        let alert = AlertViewController(nibName: R.nib.alertViewController.name, bundle: nil)
        
        _ = alert.view
        
        
        alert.titleLabel.text = title
        alert.bodyLabel.text = message
        
        alert.secondaryButton.isHidden = true
        alert.primaryButton.isHidden = true
        alert.negativeButton.isHidden = false
        alert.positiveButton.isHidden = false
        
        alert.negativeButton.setTitle(R.string.localizable.generalNo(), for: .normal)
        alert.positiveButton.setTitle(R.string.localizable.generalYes(), for: .normal)
        
        alert.positiveCompletion = confirmAction
        
        return alert
    }
    
    static func createAlertWithTextField(title: String, message: String, onTextCompletion: @escaping (String?)->()) -> UIViewController {
        let alert:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.generalSend(), style: .default, handler: { (action) in
            onTextCompletion(alert.textFields?[0].text)
        }))
        alert.addAction(UIAlertAction(title: R.string.localizable.generalCancel(), style: .cancel, handler: nil))
        alert.addTextField(configurationHandler: { (textField) in
            textField.keyboardType = .emailAddress
            textField.textAlignment = .center
        })
        return alert
    }
}
