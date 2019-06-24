//
//  AlertHelper.swift
//  fixedsmile
//
//  Created by David Blažek on 25/01/2017.
//  Copyright © 2017 Fixed. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class AlertUtils{
    
    static func createSimpleAlert(titleKey:String, messageKey:String, confirmKey:String? = nil, cancelKey:String? = nil, onConfirm: ((UIAlertAction)->())? = nil) -> UIAlertController{
        
        let alert = UIAlertController(title: NSLocalizedString(titleKey, comment: ""), message: NSLocalizedString(messageKey, comment: ""), preferredStyle: .alert)
       
        if(confirmKey != nil){
            alert.addAction(UIAlertAction(title: NSLocalizedString(confirmKey!, comment: ""), style: .default, handler: onConfirm))
        }
        
        if(cancelKey != nil){
            alert.addAction(UIAlertAction(title: NSLocalizedString(cancelKey!, comment: ""), style: .cancel, handler: nil))
        }
        
        return alert
    }
    
    static func createSimpleAlert(title:String, message:String?, completion:(()->())? ) -> UIAlertController{
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: R.string.localizable.generalOk(), style: .default, handler: {alert in
            completion?()
        }))
        
        return alert
    }
    
    static func createNoInternetAlert(completion: @escaping ()->()) -> UIAlertController{
        return AlertUtils.createSimpleAlert(title: R.string.localizable.connectionErrorTitle(), message: R.string.localizable.connectionErrorMessage(), completion: completion)
    }
    
    static func createInvalidPasswordAlert(completion: @escaping ()->()) -> UIAlertController{
        return AlertUtils.createSimpleAlert(title: R.string.localizable.unauthorizedTitle(), message: R.string.localizable.unauthorizedMessage(), completion: completion)
    }
    
    static func configureMailComposeViewController(delegate:MFMailComposeViewControllerDelegate, recipient:String, subject:String, body:String?) -> MFMailComposeViewController{
        
        let mailComposerVC = MFMailComposeViewController()
        
        mailComposerVC.mailComposeDelegate = delegate
        mailComposerVC.setToRecipients([recipient])
        mailComposerVC.setSubject(subject)
        
        if(body != nil){
            mailComposerVC.setMessageBody(body!, isHTML: false)
        }
        
        return mailComposerVC
    }
    
}
