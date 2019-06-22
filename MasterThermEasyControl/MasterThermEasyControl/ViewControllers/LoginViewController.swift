//
//  LoginViewController.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 27/05/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit
import Bond

class LoginViewController: PageBaseViewController {

    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var loginTextField: StyleableTextField!
    @IBOutlet weak var passwordTextField: StyleableTextField!
    @IBOutlet weak var loginButton: StyleableButton!
    
    let login = Observable<String?>("")
    let password = Observable<String?>("")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gradientView.progress.value = 0.7
        
        login.bidirectionalBind(to: self.loginTextField.reactive.text).dispose(in: self.bag)
        password.bidirectionalBind(to: self.passwordTextField.reactive.text).dispose(in: self.bag)
        login.observeNext {[weak self] (v) in
            self?.loginButton.isEnabled = (v?.count ?? 0) > 0
        }.dispose(in: self.bag)
    }

    @IBAction func loginButton(_ sender: Any) {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        if let user = login.value, let password = password.value {
            Session.shared.login(user: user, password: password) { (result) in
                switch result {
                case .success:
                    //change view controllers
                    self.mainViewController?.presentMainApp()
                    break
                case .unauthorized:
                    self.present(AlertUtils.createNoInternetAlert(), animated: true)
                    break
                case .connectionError:
                    self.present(AlertUtils.createInvalidPasswordAlert(), animated: true)
                    break
                case .expired:
                    //not showing
                    break
                }
            }
        }
    }
    
}
