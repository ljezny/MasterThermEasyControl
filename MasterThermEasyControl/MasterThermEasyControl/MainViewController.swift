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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadData()
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
    
    func reloadData() {
        Session.shared.loadData { (dataResponse,module, result) in
            switch result {
            case .success:
                if let dataResponse = dataResponse, let module = module {
                    let models = TemperatureModelBase.createListFromData(response: dataResponse, moduleResponse: module)
                    
                    if let mainTemperatureModel = models.first {
                        let vc = TemperatureViewController(nib: R.nib.temperatureViewController)
                        vc.model = mainTemperatureModel
                        self.addViewController(child: vc, parentView: self.contentStack)
                    }
                    if let hotWaterModel = models.last {
                        let vc = TemperatureViewController(nib: R.nib.temperatureViewController)
                        vc.model = hotWaterModel
                        self.addViewController(child: vc, parentView: self.contentStack)
                    }
                    
                    let heatPumpInfoVC = HeatPumpInfoViewController(nib: R.nib.heatPumpInfoViewController)
                    let heatPumpModel = HeatPumpModel(moduleInfo: Session.shared.loginResponse?.modules.first?.module_name)
                    heatPumpModel.updateFromData(response: dataResponse)
                    heatPumpInfoVC.model = heatPumpModel
                    //heatPumpInfoVC.mainViewController = self
                    self.addViewController(child: heatPumpInfoVC, parentView: self.bottomStack)
                    
                    let outdoorTempVC = OutdoorTemperatureViewController(nib: R.nib.outdoorTemperatureViewController)
                    outdoorTempVC.model = heatPumpModel
                    self.addViewController(child: outdoorTempVC, parentView: self.headerStack)
                    
                    let profileVC = ProfileViewController(nib: R.nib.profileViewController)
                    profileVC.mainViewController = self
                    self.addViewController(child: profileVC, parentView: self.bottomStack)
                    
                    /*if self.temperatureControllers.isEmpty {
                        TemperatureModelBase.createListFromData(response: dataResponse, moduleResponse: module).forEach({ (m) in
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
                        let heatPumpModel = HeatPumpModel(moduleInfo: Session.shared.loginResponse?.modules.first?.module_name)
                        heatPumpModel.updateFromData(response: dataResponse)
                        heatPumpInfoVC.model = heatPumpModel
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
                    }*/
                    
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
    }
    
}
