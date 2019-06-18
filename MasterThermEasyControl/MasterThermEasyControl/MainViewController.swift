//
//  MainViewController.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 16/05/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit

class MainViewController: UIPageViewController, UIPageViewControllerDataSource {

    var controllers = [PageBaseViewController]()
    /*IntroViewController(nib: R.nib.introViewController),
        LoginViewController(nib: R.nib.loginViewController),
        TemperatureViewController(nib: R.nib.temperatureViewController),
        TemperatureViewController(nib: R.nib.temperatureViewController),
        TemperatureViewController(nib: R.nib.temperatureViewController),
        TemperatureViewController(nib: R.nib.temperatureViewController)] as [UIViewController]*/
    
    var temperatureControllers = [TemperatureViewController]()
    
    init() {
        super.init(transitionStyle: UIPageViewController.TransitionStyle.scroll, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func presentLogin(direction: UIPageViewController.NavigationDirection) {
        self.temperatureControllers.removeAll()
        
        let loginViewController = LoginViewController(nib: R.nib.loginViewController)
        loginViewController.mainViewController = self
        
        let introViewController = IntroViewController(nib: R.nib.introViewController)
        introViewController.mainViewController = self
        
        self.controllers.removeAll()
        self.controllers.append(introViewController)
        self.controllers.append(loginViewController)
        if let firstVC = controllers.first {
            self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func goToLast() {
        if let lastVC = controllers.last {
            self.setViewControllers([lastVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func presentMainApp() {
        Session.shared.loadData { (dataResponse, result) in
            switch result {
            case .success:
                if let dataResponse = dataResponse {
                    if self.temperatureControllers.isEmpty {
                        TemperatureModelBase.createListFromData(response: dataResponse).forEach({ (m) in
                            let vc = TemperatureViewController(nib: R.nib.temperatureViewController)
                            vc.model = m
                            self.temperatureControllers.append(vc)
                        })
                        self.controllers.removeAll()
                        self.temperatureControllers.forEach({ (vc) in
                            vc.mainViewController = self
                            self.controllers.append(vc)
                        })
                        
                        let heatPumpInfoVC = HeatPumpInfoViewController(nib: R.nib.heatPumpInfoViewController)
                        heatPumpInfoVC.mainViewController = self
                        self.controllers.append(heatPumpInfoVC)
                        
                        let profileVC = ProfileViewController(nib: R.nib.profileViewController)
                        profileVC.mainViewController = self
                        self.controllers.append(profileVC)
                        
                        if let firstVC = self.controllers.first {
                            self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
                        }
                    } else {
                        self.temperatureControllers.forEach({ (vc) in
                            vc.model?.updateFromData(response: dataResponse)
                        })
                    }
                }
                break
            case .connectionError:
                self.present(AlertUtils.createNoInternetAlert(), animated: true)
                //TODO: some retry needed
                break
            case .unauthorized:
                self.presentLogin(direction: .reverse)
                break
            case .expired:
                self.relogin()
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        
        setupPageControl()
        
        setupViewResizerOnKeyboardShown()
        
        self.dataSource = self
        
        controllers.append(InitialViewController(nib: R.nib.initialViewController))
        
        if let firstVC = controllers.first {
            self.setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
        }
        
        self.relogin()
    }
    
    func relogin() {
        Session.shared.relogin { (result) in
            switch result {
            case .success:
                self.presentMainApp()
                break
            case .connectionError:
                self.present(AlertUtils.createNoInternetAlert(), animated: true)
                //TODO: some retry needed
                break
            case .unauthorized:
                self.presentLogin(direction: .forward)
                break
            case .expired:
                //no op
                break
            }
        }
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        for subView in self.view.subviews as! [UIView] {
            if subView is UIScrollView {
                subView.frame = self.view.bounds
            } else if subView is UIPageControl {
                self.view.bringSubviewToFront(subView)
            }
        }
        super.viewDidLayoutSubviews()
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.4)
        appearance.currentPageIndicatorTintColor = UIColor.white
        appearance.backgroundColor = UIColor.clear
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = controllers.index(of: viewController as! PageBaseViewController) {
            if index < controllers.count - 1 {
                return controllers[index + 1]
            } else {
                return nil
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = controllers.index(of: viewController as! PageBaseViewController) {
            if index > 0 {
                return controllers[index - 1]
            } else {
                return nil
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return controllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        return 0
    }
    
    func setupViewResizerOnKeyboardShown() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardAdjustFrame),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardAdjustFrame),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardAdjustFrame),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    @objc func keyboardAdjustFrame(notification: Notification) {
        
        if  let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
            let window = self.view.window?.frame {
            
            let options = UIView.AnimationOptions(rawValue: curve << 16)
            let keyboardHeight = notification.name == UIResponder.keyboardWillHideNotification ? 0 : keyboardSize.height
            
            self.view.frame = CGRect(x: self.view.frame.origin.x,
                                     y: self.view.frame.origin.y,
                                     width: self.view.frame.width,
                                     height: window.origin.y + window.height - keyboardHeight)
            
            UIView.animate(withDuration: duration, delay: 0, options: options,
                           animations: {
                            self.view?.window?.layoutIfNeeded()
            },
                           completion: nil
            )
        } else {
            debugPrint("We're showing the keyboard and either the keyboard size or window is nil: panic widely.")
        }
    }

}
