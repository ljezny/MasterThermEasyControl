//
//  TodayViewController.swift
//  MasterThermEasyControl.Today
//
//  Created by Lukas Jezny on 16/06/2019.
//  Copyright © 2019 Lukas Jezny. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var roomRealTemperatureLabel: StyleableLabel!
    @IBOutlet weak var roomSetTemperatureLabel: StyleableLabel!
    @IBOutlet weak var waterRealTemperatureLabel: StyleableLabel!
    @IBOutlet weak var outsideTempLabel: StyleableLabel!
    @IBOutlet weak var heatWaterLabel: StyleableLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        Session.shared.relogin { (result) in
            switch result {
            case .success:
                Session.shared.loadData(completion: { (response,module, result) in
                    switch result {
                    case .success:
                        if let response = response, let module = module {
                            let heatModel = HeatModel.createListFromData(response: response, moduleResponse: module).first
                            
                            let hotWaterModel = HotWaterModel()
                            hotWaterModel.updateFromData(response: response)
                            
                            let heatPumpModel = HeatPumpModel(moduleInfo: Session.shared.loginResponse?.modules.first?.module_name)
                            heatPumpModel.updateFromData(response: response)
                            
                            heatModel?.setTemperature.map({ (d) -> String? in
                                return NumberFormatUtils.formatTemperature(value: d)
                            }).bind(to: self.roomSetTemperatureLabel.reactive.text).dispose(in: self.bag)
                            heatModel?.realTemperature.map({ (d) -> String? in
                                return NumberFormatUtils.formatTemperature(value: d)
                            }).bind(to: self.roomRealTemperatureLabel.reactive.text).dispose(in: self.bag)
                            
                            hotWaterModel.realTemperature.map({ (d) -> String? in
                                return NumberFormatUtils.formatTemperature(value: d)
                            }).bind(to: self.waterRealTemperatureLabel.reactive.text).dispose(in: self.bag)
                            heatPumpModel.outsideTemperature.map({ (d) -> String? in
                                return NumberFormatUtils.formatTemperature(value: d)
                            }).bind(to: self.outsideTempLabel.reactive.text).dispose(in: self.bag)
                            heatPumpModel.realHeatWaterTemperature.map({ (d) -> String? in
                                return NumberFormatUtils.formatTemperature(value: d)
                            }).bind(to: self.heatWaterLabel.reactive.text).dispose(in: self.bag)
                            
                            self.updateGradient(v: heatModel?.realTemperature.value ?? 0.0, min: heatModel?.minSetTemperature.value ?? 0.0, max: heatModel?.maxSetTemperature.value ?? 1.0)
                        }
                        completionHandler(NCUpdateResult.newData)
                        break
                    default:
                        completionHandler(NCUpdateResult.failed)
                        break
                    }
                })
                break
            default:
                completionHandler(NCUpdateResult.failed)
                break
            }
        }
        
        
    }
    func updateGradient(v: Double, min: Double, max:Double) {
        self.gradientView.progress.value = v / (max - min)
    }
}
