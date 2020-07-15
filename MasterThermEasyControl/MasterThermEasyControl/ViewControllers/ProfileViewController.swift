//
//  ProfileViewController.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 16/06/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit

import GZIP

class ProfileViewController: BaseViewController {
    @IBAction func logoutAction(_ sender: Any) {
        Session.shared.clearCredentials()
        self.mainViewController?.logoutCompletion?()
    }
}
