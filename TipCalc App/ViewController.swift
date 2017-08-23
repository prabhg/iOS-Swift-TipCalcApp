//
//  ViewController.swift
//  TipCalc App
//
//  Created by  Prabhh Ghuman on 8/18/17.
//  Copyright © 2017  Prabhh Ghuman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!

    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var tipSelector: UISegmentedControl!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    
    @IBOutlet weak var split2: UILabel!
    @IBOutlet weak var split3: UILabel!
    @IBOutlet weak var split4: UILabel!
    
    // array to store Float values of tip-percentages
    var tipPercentages: [Float] = [Float](repeating: 0.0, count: 3)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the keyboard to type "Decimal"
        amountField.keyboardType = UIKeyboardType.decimalPad
        
        // setup the hamburger menu
        setupSlideMenu();
        
        // set focus to text field when app opens
        amountField.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // update the values in the tip-selector.
        updateTipSelectorValues();
        
        // check if the revealViewController menu is in "open" position, and close it if it is
        if (self.revealViewController().frontViewPosition != FrontViewPosition.left) {
            // close the menu
            self.revealViewController().revealToggle(animated: true)
        }
        
        // the tip settings value may have changed. Re run the calculation
        updateCalculations()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // check if the revealViewController menu is in "open" position, and close it if it is
        if (self.revealViewController().frontViewPosition != FrontViewPosition.left) {
            // close the menu
            self.revealViewController().revealToggle(animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // sets up the sliding hamburger menu
    func setupSlideMenu() {
        if revealViewController() != nil {
            menuButton.target = revealViewController();
            menuButton.action = #selector( SWRevealViewController.revealToggle(_:) );
            revealViewController().rearViewRevealWidth = 200
            
            // add gesture recognizers to revealViewController so as to close the rear view when tapped
            // on front view
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
    }
    
    // update the tip values in UISegmentedControl from UserDefaults if available, else use some default val
    func updateTipSelectorValues() {
        // default values for the tips (in percentages) if user hasn't set them yet in settings
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
    
        // update the values in UISegmentedControl
        tipSelector.setTitle("\(Int(tip1Val))%", forSegmentAt: 0)
        tipSelector.setTitle("\(Int(tip2Val))%", forSegmentAt: 1)
        tipSelector.setTitle("\(Int(tip3Val))%", forSegmentAt: 2)
        
        // update the values in memory so we can read them later
        tipPercentages[0] = tip1Val / 100
        tipPercentages[1] = tip2Val / 100
        tipPercentages[2] = tip3Val / 100
    }
    
    // runs the tip amount calculations and updated the labels
    func updateCalculations () {
        let selectedTipPercent: Float = tipPercentages[tipSelector.selectedSegmentIndex]
        let amount = Float(amountField.text!) ?? 0.0
        let tipVal = amount * selectedTipPercent
        let totalVal = amount + tipVal
        
        tipAmount.text = "$\(toDecimalPlaces(tipVal, 2))"
        totalAmount.text = "$\(toDecimalPlaces(totalVal, 2))"
        
        split2.text = "$\(toDecimalPlaces(totalVal/2, 2))"
        split3.text = "$\(toDecimalPlaces(totalVal/3, 2))"
        split4.text = "$\(toDecimalPlaces(totalVal/4, 2))"
    }
    
    // utility method to format a Float to set number of digits. Returns string
    func toDecimalPlaces (_ number: Float, _ decimalPlaces: Int) -> String {
        let formatStr = "%." + String(decimalPlaces) + "f"
        return String(format: formatStr, number)
    }
    
    // handler for amount-textfield or tip-segementedControl value change
    @IBAction func runCalculations (_ sender: AnyObject) {
        // re-run the calculations and update the labels
        updateCalculations()
    }
    
    // dismiss keyboard when touched anywhere on the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /*func formatNumber(_ number: Float, _ fractionDigits: Int) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = fractionDigits
        formatter.maximumFractionDigits = fractionDigits
        return formatter.string(from: NSNumber(value: number)) ?? "\(self)"
    }
    
    func round(_ value: Float, _ places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(Double(value) * divisor) / divisor
    }*/

}
