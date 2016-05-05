//
//  SettingsTVC.swift
//  Music Video
//
//  Created by Emir haktan Ozturk on 04/05/16.
//  Copyright © 2016 Emir haktan Ozturk. All rights reserved.
//

import UIKit

class SettingsTVC: UITableViewController {

    @IBOutlet var aboutDisplay: UILabel!
    @IBOutlet var feedbackDisplay: UILabel!
    @IBOutlet var securityDisplay: UILabel!
    @IBOutlet var touchID: UISwitch!
    @IBOutlet var bestImageQualityDisplay: UILabel!
    @IBOutlet var APICnt: UILabel!
    @IBOutlet var sliderCnt: UISlider!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        tableView.separatorStyle = .None
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "prefferedFontChange", name: UIContentSizeCategoryDidChangeNotification, object: nil)

        tableView.alwaysBounceVertical = false
        
        touchID.on = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil){
            
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
            APICnt.text = "\(theValue)"
            sliderCnt.value = Float(theValue)
            
        }
        
    }
   
    @IBAction func touchIdSec(sender: UISwitch) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if touchID.on{
            defaults.setBool(touchID.on, forKey: "SecSetting")
        }
        else{
            defaults.setBool(false, forKey: "SecSetting")
        }
        
    }

    
    
    
    @IBAction func valueChanged(sender: AnyObject) {// slider slide change to apiCnt number
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(Int(sliderCnt.value), forKey: "APICNT") // slider value type is float so change it to int
        APICnt.text = ("\(Int(sliderCnt.value))")  //ToString()
        
    }
    
    
    func prefferedFontChange(){
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedbackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestImageQualityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        APICnt.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name:UIContentSizeCategoryDidChangeNotification, object: nil)
    }
}
