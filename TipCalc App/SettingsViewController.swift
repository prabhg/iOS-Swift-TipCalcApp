//
//  SettingsViewController.swift
//  TipCalc App
//
//  Created by  Prabhh Ghuman on 8/19/17.
//  Copyright © 2017  Prabhh Ghuman. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var tip1Slider: UISlider!
    @IBOutlet weak var tip2Slider: UISlider!
    @IBOutlet weak var tip3Slider: UISlider!
    
    @IBOutlet weak var tip1Label: UILabel!
    @IBOutlet weak var tip2Label: UILabel!
    @IBOutlet weak var tip3Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // default values for the tips (in percentages) if user hasn't set them yet
        var tip1Val: Float = 10.0
        var tip2Val: Float = 15.0
        var tip3Val: Float = 20.0
        
        let defaults = UserDefaults.standard
        
        // check if user has already set a default. If yes, then update the variables
        if (defaults.object(forKey: "tip1Percentage") != nil) {
            tip1Val = defaults.float(forKey: "tip1Percentage") * 100
        }
        if (defaults.object(forKey: "tip2Percentage") != nil) {
            tip2Val = defaults.float(forKey: "tip2Percentage") * 100
        }
        if (defaults.object(forKey: "tip3Percentage") != nil) {
            tip3Val = defaults.float(forKey: "tip3Percentage") * 100
        }
        
        // set values on sliders from the slider values
        tip1Slider.value = Float(tip1Val)
        tip2Slider.value = Float(tip2Val)
        tip3Slider.value = Float(tip3Val)
        
        // update the labels from slider values
        tip1Label.text = "\(Int(tip1Slider.value))%"
        tip2Label.text = "\(Int(tip2Slider.value))%"
        tip3Label.text = "\(Int(tip3Slider.value))%"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // handler for when any of the tip-slider value changes
    @IBAction func onTipSettingChanged(_ sender: UISlider) {
        // we want integer values for percentages, so use a "step" value of 1
        let step: Float = 1
        let halfStep : Float = Float(step / 2)
        
        // Snap slider's value to the nearest step value...
        sender.setValue((Float)((Int)((sender.value + halfStep) / step) * Int(step)), animated: false)
        
        let defaults = UserDefaults.standard

        // sender tag 0 = 1st tip slider
        // sender tag 1 = 2nd tip slider
        // sender tag 2 = 3rd tip slider
        // save in "default" and update the label
        if (sender.tag == 0) {
            defaults.set(Float(tip1Slider.value / 100), forKey: "tip1Percentage")
            tip1Label.text = "\(Int(tip1Slider.value))%"
        } else if (sender.tag == 1) {
            defaults.set(Float(tip2Slider.value / 100), forKey: "tip2Percentage")
            tip2Label.text = "\(Int(tip2Slider.value))%"
        } else if (sender.tag == 2) {
            defaults.set(Float(tip3Slider.value / 100), forKey: "tip3Percentage")
            tip3Label.text = "\(Int(tip3Slider.value))%"
        }
    }

    // handler for "done" button. Use this to dismiss the settings view and go back to tip-calculator view
    @IBAction func onDonePressed(_ sender: UIBarButtonItem) {
        // dismiss the view controller if you present the view using modal
        self.dismiss(animated: true, completion: nil)
        
        // pop the view controller if you present the view using "push" segue
        navigationController?.popViewController(animated: true)
    }
}
