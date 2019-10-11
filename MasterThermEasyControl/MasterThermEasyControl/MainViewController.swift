//
//  MainViewController.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 11/10/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.setCollectionViewLayout(createLayout(), animated: false)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(R.nib.temperatureCollectionViewCell)
        
        self.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.temperatureCollectionViewCell, for: indexPath)!
        
        return cell
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                         subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
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
    
}
