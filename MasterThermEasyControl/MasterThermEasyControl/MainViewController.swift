//
//  MainViewController.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 16/05/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit

class MainViewController: UIPageViewController, UIPageViewControllerDataSource {

    var controllers = [UIViewController]()
    /*IntroViewController(nib: R.nib.introViewController),
        LoginViewController(nib: R.nib.loginViewController),
        TemperatureViewController(nib: R.nib.temperatureViewController),
        TemperatureViewController(nib: R.nib.temperatureViewController),
        TemperatureViewController(nib: R.nib.temperatureViewController),
        TemperatureViewController(nib: R.nib.temperatureViewController)] as [UIViewController]*/
    
    init() {
        super.init(transitionStyle: UIPageViewController.TransitionStyle.scroll, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func presentLogin(direction: UIPageViewController.NavigationDirection) {
        let loginViewController = LoginViewController(nib: R.nib.loginViewController)
        loginViewController.mainViewController = self
        
        self.controllers.removeAll()
        self.controllers.append(IntroViewController(nib: R.nib.introViewController))
        self.controllers.append(loginViewController)
        if let firstVC = controllers.first {
            self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func presentMainApp() {
        Session.shared.loadData { (dataResponse, result) in
            switch result {
            case .success:
                self.controllers.removeAll()
                self.controllers.append(TemperatureViewController(nib: R.nib.temperatureViewController))
                self.controllers.append(TemperatureViewController(nib: R.nib.temperatureViewController))
                if let firstVC = self.controllers.first {
                    self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
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
                //no op
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPageControl()
        
        self.dataSource = self
        
        controllers.append(InitialViewController(nib: R.nib.initialViewController))
        
        if let firstVC = controllers.first {
            self.setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
        }
        
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
        if let index = controllers.index(of: viewController) {
            if index < controllers.count - 1 {
                return controllers[index + 1]
            } else {
                return controllers.first
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = controllers.index(of: viewController) {
            if index > 0 {
                return controllers[index - 1]
            } else {
                return controllers.last
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
}
