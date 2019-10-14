//
//  LoginViewController.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 27/05/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit
import Bond

class LoginViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var loginTextField: StyleableTextField!
    @IBOutlet weak var passwordTextField: StyleableTextField!
    @IBOutlet weak var loginButton: StyleableButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
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
    
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIControl.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIControl.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size

        let tabbarHeight = tabBarController?.tabBar.frame.size.height ?? 0
        let toolbarHeight = navigationController?.toolbar.frame.size.height ?? 0
        let bottomInset = keyboardSize.height - tabbarHeight - toolbarHeight

        scrollView.contentInset.bottom = bottomInset
        scrollView.scrollIndicatorInsets.bottom = bottomInset
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        gradientView.progress.value = 0.7
        
        login.bidirectionalBind(to: self.loginTextField.reactive.text).dispose(in: self.bag)
        password.bidirectionalBind(to: self.passwordTextField.reactive.text).dispose(in: self.bag)
        login.observeNext {[weak self] (v) in
            self?.loginButton.isEnabled = (v?.count ?? 0) > 0
        }.dispose(in: self.bag)
        
        setupKeyboardNotifications()
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
            loginButton(self)
        }
        
        return true;
    }
    
}
