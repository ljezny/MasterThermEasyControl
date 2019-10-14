//
//  MainViewController.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 11/10/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var headerStack: UIStackView!
    @IBOutlet weak var contentStack: UIStackView!
    @IBOutlet weak var bottomStack: UIStackView!
    @IBOutlet weak var footerStack: UIStackView!
    
    let heatPumpInfoVC = HeatPumpInfoViewController(nib: R.nib.heatPumpInfoViewController)
    let outdoorTempVC = OutdoorTemperatureViewController(nib: R.nib.outdoorTemperatureViewController)
    let profileVC = ProfileViewController(nib: R.nib.profileViewController)
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        heatPumpInfoVC.mainViewController = self
        self.addViewController(child: heatPumpInfoVC, parentView: self.bottomStack)
        
        outdoorTempVC.mainViewController = self
        self.addViewController(child: outdoorTempVC, parentView: self.headerStack)
        
        profileVC.mainViewController = self
        self.addViewController(child: profileVC, parentView: self.bottomStack)
        
        self.reloadData()
        
        self.present(InitialViewController(nib: R.nib.initialViewController), animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        contentStack.axis = isLandscape() || isLargeWidthWindow() ? .horizontal : .vertical
        contentStack.distribution = isLandscape() || isLargeWidthWindow() ? .fillEqually : .fill
        bottomStack.axis = isLargeWidthWindow() ? .horizontal : .vertical
        bottomStack.distribution = isLandscape() || isLargeWidthWindow() ? .fillEqually : .fill
    }
    
    func relogin() {
        Session.shared.relogin { (result) in
            switch result {
            case .success:
                let heatPumpModel = HeatPumpModel(moduleInfo: Session.shared.loginResponse?.modules.first?.module_name)
                self.heatPumpInfoVC.model = heatPumpModel
                self.outdoorTempVC.model = heatPumpModel
                
                self.reloadData()
                break
            case .connectionError:
                self.present(AlertUtils.createNoInternetAlert(completion: {
                    DispatchQueue.main.after(when: 2.0, block: {
                        self.relogin() // retry
                    })
                    
                }), animated: true)
                break
            case .unauthorized:
                self.presentLogin()
                break
            case .expired:
                //no op
                break
            }
        }
    }
    var temperatureViewControllers = [TemperatureViewController]()
    func reloadData() {
        Session.shared.loadData { (dataResponse,module, result) in
            switch result {
            case .success:
                if let dataResponse = dataResponse, let module = module {
                    let models = TemperatureModelBase.createListFromData(response: dataResponse, moduleResponse: module)
                    
                    if self.temperatureViewControllers.isEmpty {
                        models.forEach { (m) in
                            let vc = TemperatureViewController(nib: R.nib.temperatureViewController)
                            vc.model = m
                            self.addViewController(child: vc, parentView: self.contentStack)
                            self.temperatureViewControllers.append(vc)
                        }
                    } else {
                        self.temperatureViewControllers.forEach { (vc) in
                            vc.model?.updateFromData(response: dataResponse)
                        }
                    }
                    
                    self.heatPumpInfoVC.model?.updateFromData(response: dataResponse)
                    self.outdoorTempVC.model?.updateFromData(response: dataResponse)
                    
                }
                break
            case .connectionError:
                self.present(AlertUtils.createNoInternetAlert(completion: {
                    self.reloadData() //retry
                }), animated: true)
                //TODO: some retry needed
                break
            case .unauthorized:
                self.presentLogin()
                break
            case .expired:
                self.relogin()
                break
            }
        }
    }
    
    func presentLogin() {
        let loginViewController = LoginViewController(nib: R.nib.loginViewController)
        loginViewController.loginCompletion = {[weak self] in
            loginViewController.dismiss(animated: true, completion: nil)
            self?.reloadData()
        }
        self.present(loginViewController, animated: true, completion: nil)
    }
    
    func addViewController(child: UIViewController, parentView: UIStackView) {
        addChild(child)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        parentView.addArrangedSubview(child.view)
        child.didMove(toParent: self)
        
        child.view.alpha = 0.0
        UIView.animate(withDuration: 1.0) {
            child.view.alpha = 1.0
        }
    }
    
    func removeViewController(child: UIViewController) {
        removeViewController(child: child)
        child.didMove(toParent: nil)
        child.view.removeFromSuperview()
    }
}
