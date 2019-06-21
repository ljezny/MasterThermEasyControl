//
//  TemperatureViewController.swift
//  MasterThermEasyControl
//
//  Created by Lukas Jezny on 16/05/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit
import Bond

class TemperatureViewController: PageBaseViewController {
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var knob: Knob!
    @IBOutlet weak var setTemperatureLabel: UILabel!
    @IBOutlet weak var realTemperatureLabel: UILabel!
    @IBOutlet weak var minSetTemperatureLabel: StyleableLabel!
    @IBOutlet weak var maxSetTemperatureLabel: StyleableLabel!
    @IBOutlet weak var nameLabel: StyleableLabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    var model: TemperatureModelBase? = nil {
        didSet {
            //setup bindings
            let _ = self.view
            
            model?.setTemperature.map({ (d) -> String? in
                return NumberFormatUtils.formatTemperature(value: d)
            }).bind(to: setTemperatureLabel.reactive.text).dispose(in: self.bag)
            model?.realTemperature.map({ (d) -> String? in
                return NumberFormatUtils.formatTemperature(value: d)
            }).bind(to: realTemperatureLabel.reactive.text).dispose(in: self.bag)
            model?.minSetTemperature.map({ (d) -> String? in
                return NumberFormatUtils.formatTemperature(value: d)
            }).bind(to: minSetTemperatureLabel.reactive.text).dispose(in: self.bag)
            model?.maxSetTemperature.map({ (d) -> String? in
                return NumberFormatUtils.formatTemperature(value: d)
            }).bind(to: maxSetTemperatureLabel.reactive.text).dispose(in: self.bag)
            self.knob.minimumValue = model?.minSetTemperature.value ?? 0.0
            self.knob.maximumValue = model?.maxSetTemperature.value ?? 1.0
            model?.setTemperature.bidirectionalBind(to: self.knob.value).dispose(in: self.bag)
            self.knob.setValue(model?.setTemperature.value ?? 0.0, animated: true)
            self.updateGradient(v: model?.realTemperature.value ?? 0.0)
            self.nameLabel.text = model?.name
            if let icon = model?.icon {
               self.iconImage.image = UIImage.init(named: icon)
            }
            
            var bounceValue = self.model?.setTemperature.value
            self.model?.setTemperature.skip(first: 1).observeNext(with: {[weak self] (v) in
                if bounceValue != v {
                    bounceValue = v
                    DispatchQueue.main.after(when: 2.0, block: {
                        if bounceValue == v {
                            self?.postValue()
                        }
                    })
                }
                
            }).dispose(in: self.bag)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.knob.value.skip(first: 1).observeNext {[weak self] (v) in
            self?.updateGradient(v: v ?? 0.0)
        }.dispose(in: self.bag)

    }
    
    func updateGradient(v: Double) {
        self.gradientView.progress.value = v / (self.knob.maximumValue - self.knob.minimumValue)
    }
    
    func postValue() {
        //api call
        //dont forget debounce
        for updatableParam in model?.getUpdatedValues() ?? [String:String]() {
            Session.shared.setData(parameter: updatableParam.key, value: updatableParam.value) { (dataResponse, result) in
                switch result {
                case .success:
                    if dataResponse?.error.errorId ?? 0 != 0 {
                        self.present(AlertUtils.createSimpleAlert(title: R.string.localizable.generalAppname(), message: dataResponse?.error.errorMessage), animated: true, completion: {
                            
                        })
                    }
                   // self.mainViewController?.presentMainApp() //reload data
                    break
                case .connectionError:
                    self.present(AlertUtils.createNoInternetAlert(), animated: true)
                    //TODO: some retry needed
                    break
                case .unauthorized:
                    self.mainViewController?.presentLogin(direction: .reverse)
                    break
                case .expired:
                    self.mainViewController?.relogin()
                    break
                }
            }
        }
    }
}
