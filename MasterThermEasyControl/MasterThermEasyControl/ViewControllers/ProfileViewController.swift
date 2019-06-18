//
//  ProfileViewController.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 16/06/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit
import MessageUI

class ProfileViewController: PageBaseViewController,MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func contactAction(_ sender: Any) {
        guard MFMailComposeViewController.canSendMail() else {
            self.present(AlertUtils.createSimpleAlert(title: R.string.localizable.generalAppname(), message: R.string.localizable.profileContactError()), animated: true, completion: nil)
            return
        }
        self.present(AlertUtils.configureMailComposeViewController(delegate: self, recipient: "ljezny@gmail.com", subject: R.string.localizable.generalAppname(), body: nil), animated: true)
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        Session.shared.clearCredentials()
        self.mainViewController?.presentLogin(direction: UIPageViewController.NavigationDirection.reverse)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
      self.dismiss(animated: true, completion: nil)
    }
    
}
