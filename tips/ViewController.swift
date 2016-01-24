//
//  ViewController.swift
//  tips
//
//  Created by Senyang Zhuang on 1/22/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit


class ViewController: UIViewController {




    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var fivePayLabel: UILabel!
    @IBOutlet weak var fourPayLabel: UILabel!
    @IBOutlet weak var threePayLabel: UILabel!
    @IBOutlet weak var twoPayLabel: UILabel!
    @IBOutlet weak var fiveStarLabel: UILabel!
    @IBOutlet weak var fourStarLabel: UILabel!
    @IBOutlet weak var threeStarLabel: UILabel!
    @IBOutlet weak var twoStarLabel: UILabel!

    @IBAction func clearButton(sender: AnyObject) {
    
            billField.text = nil
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .CurrencyStyle
            let symbol = formatter.currencySymbol
            tipLabel.text = "\(symbol)0.00"
            totalLabel.text = "\(symbol)0.00"
            twoPayLabel.text = "\(symbol)0.00"
            threePayLabel.text = "\(symbol)0.00"
            fourPayLabel.text = "\(symbol)0.00"
            fivePayLabel.text = "\(symbol)0.00"
            
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        // Sets the title in the Navigation Bar
        self.title = "Tip Calculator"
        
        // ...
        let defaults = NSUserDefaults.standardUserDefaults()
        let lastBill = defaults.doubleForKey("lastBill")
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        
        let lastHour = defaults.integerForKey("lastHour")
        let lastMins = defaults.integerForKey("lastMins")
        if (defaults.objectForKey("lastHour") != nil) {
        if hour == lastHour && minutes - lastMins < 10 || hour - lastHour == 1 && minutes + 60 - lastMins < 10{
        
            let formatter = NSNumberFormatter()
            formatter.numberStyle = .CurrencyStyle
            let symbol = formatter.currencySymbol
            billField.text = String(format: "%.2f", lastBill)
            var tipPercentages = [0.18, 0.2, 0.22]
            var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
            var tip = lastBill * tipPercentage
            var total = lastBill + tip

            tipLabel.text = String(format: "\(symbol)%.2f", tip)
            totalLabel.text = String(format: "\(symbol)%.2f", total)
            twoPayLabel.text = String(format: "\(symbol)%.2f", total/2)
            threePayLabel.text = String(format: "\(symbol)%.2f", total/3)
            fourPayLabel.text = String(format: "\(symbol)%.2f", total/4)
            fivePayLabel.text = String(format: "\(symbol)%.2f", total/5)
            
            
            }
        }
       billField.becomeFirstResponder()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onEditingChanged(sender: AnyObject) {
        var billAmount = NSString(string: billField.text!).doubleValue
        var tipPercentages = [0.18, 0.2, 0.22]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
    
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        let symbol = formatter.currencySymbol
        tipLabel.text = String(format: "\(symbol)%.2f", tip)
        totalLabel.text = String(format: "\(symbol)%.2f", total)
        twoPayLabel.text = String(format: "\(symbol)%.2f", total/2)
        threePayLabel.text = String(format: "\(symbol)%.2f", total/3)
        fourPayLabel.text = String(format: "\(symbol)%.2f", total/4)
        fivePayLabel.text = String(format: "\(symbol)%.2f", total/5)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(billAmount, forKey: "lastBill")
        defaults.synchronize()
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        defaults.setInteger(hour, forKey: "lastHour")
        defaults.setInteger(minutes, forKey: "lastMins")
        defaults.synchronize()
        
        
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //print("view will appear")
        // This is a good place to retrieve the default tip percentage from NSUserDefaults
        // and use it to update the tip amount
        let defaults = NSUserDefaults.standardUserDefaults()
        var tipPercentages = [0.18, 0.2, 0.22]
        let defaultControlIndex = defaults.integerForKey("default_tip_percentage")
        tipControl.selectedSegmentIndex = defaultControlIndex
        tipLabel.center.x  -= view.bounds.width
        totalLabel.center.x -= view.bounds.width
        tipControl.center.x -= view.bounds.width
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //print("view did appear")
        UIView.animateWithDuration(0.5, animations: {
            self.tipLabel.center.x += self.view.bounds.width
            self.totalLabel.center.x += self.view.bounds.width
        })
        UIView.animateWithDuration(0.5, delay: 0.3, options: [], animations: {
            self.tipControl.center.x += self.view.bounds.width
            }, completion: nil)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        //print("view did disappear")
    }
}

