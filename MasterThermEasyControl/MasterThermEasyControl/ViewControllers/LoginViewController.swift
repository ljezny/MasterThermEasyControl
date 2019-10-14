//
//  LoginViewController.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 27/05/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit
import Bond

class LoginViewController: BaseViewController {

    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var loginTextField: StyleableTextField!
    @IBOutlet weak var passwordTextField: StyleableTextField!
    @IBOutlet weak var loginButton: StyleableButton!
    
    let login = Observable<String?>("")
    let password = Observable<String?>("")
    
    var loginCompletion: (()->())?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            Session.shared.login(user: user, password: password) {[weak self] (result) in
                switch result {
                case .success:
                    //change view controllers
                    self?.loginCompletion?()
                    break
                case .unauthorized:
                    self?.present(AlertUtils.createNoInternetAlert(completion: {
                        //do nothing
                    }), animated: true)
                    break
                case .connectionError:
                    self?.present(AlertUtils.createInvalidPasswordAlert(completion: {
                        //do nothing, user will try to login
                    }), animated: true)
                    break
                case .expired:
                    //not showing
                    break
                }
            }
        }
    }
    
}
