//
//  BaseViewController.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 16/06/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit
import MessageUI

class BaseViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
    weak var mainViewController:MainViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func contactAction(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            
            // Configure the fields of the interface.
            composeVC.setToRecipients(["ljezny@gmail.com" ])
            composeVC.setSubject("MasterTherm Easy Control feedback")
            composeVC.setMessageBody(getExportLogBody(), isHTML: false)
            
            let attachmentData = NSMutableData()
            for logFileData in (UIApplication.shared.delegate as! AppDelegate).logFileDataArray {
                attachmentData.append(logFileData as Data)
            }
            
            if let data = attachmentData.gzippedData(withCompressionLevel: 1.0) {
                composeVC.addAttachmentData(data, mimeType: "application/gzip ", fileName: "diagnostic.zip")
            } else {
                composeVC.addAttachmentData(attachmentData as Data, mimeType: "text/plain", fileName: "diagnostic.log")
            }
            
            self.present(composeVC, animated: true, completion: nil)
        }
    }
    var mailComposerVC:MFMailComposeViewController?
       
       func getExportLogBody() -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateStyle = .short
           dateFormatter.timeStyle = .short
           
           return "\(NSLocalizedString("profile.describe.problem", comment: ""))\n\n\n\nName: \(UIDevice.current.name), Version: \(UIDevice.current.systemVersion), Model: \(UIDevice.current.model), Time: \(dateFormatter.string(from: Date())), AppVersion:\(Bundle.main.infoDictionary!["CFBundleShortVersionString"] ?? ""),\(Bundle.main.infoDictionary!["CFBundleVersion"] ?? "")\n"
       }
       
       @objc(mailComposeController:didFinishWithResult:error:)
       func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
           self.dismiss(animated: true, completion: nil)
       }
}
