//
//  SettingsViewController.swift
//  tips
//
//  Created by Senyang Zhuang on 1/22/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var tipControl: UISegmentedControl!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        // This is a good place to retrieve the default tip percentage from NSUserDefaults
        // and use it to update the tip amount
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.objectForKey("default_tip_percentage") != nil{
        let defaultControlIndex = defaults.integerForKey("default_tip_percentage")
            print(tipControl)
            tipControl.selectedSegmentIndex = defaultControlIndex
            
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
        var index = tipControl.selectedSegmentIndex
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(index, forKey: "default_tip_percentage")
        defaults.synchronize()
        
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    

}
