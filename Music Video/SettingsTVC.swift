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
        tableView.separatorStyle = .none
        
        NotificationCenter.default.addObserver(self, selector: #selector(SettingsTVC.prefferedFontChange), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)

        tableView.alwaysBounceVertical = false
        
        touchID.isOn = UserDefaults.standard.bool(forKey: "SecSetting")
        
        if(UserDefaults.standard.object(forKey: "APICNT") != nil){
            
            let theValue = UserDefaults.standard.object(forKey: "APICNT") as! Int
            APICnt.text = "\(theValue)"
            sliderCnt.value = Float(theValue)
            
        }
        
    }
   
    @IBAction func touchIdSec(_ sender: UISwitch) {
        
        let defaults = UserDefaults.standard
        if touchID.isOn{
            defaults.set(touchID.isOn, forKey: "SecSetting")
        }
        else{
            defaults.set(false, forKey: "SecSetting")
        }
        
    }

    
    
    
    @IBAction func valueChanged(_ sender: AnyObject) {// slider slide change to apiCnt number
        
        let defaults = UserDefaults.standard
        defaults.set(Int(sliderCnt.value), forKey: "APICNT") // slider value type is float so change it to int
        APICnt.text = ("\(Int(sliderCnt.value))")  //ToString()
        
    }
    
    
    func prefferedFontChange(){
        aboutDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        feedbackDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        securityDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        bestImageQualityDisplay.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        APICnt.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
    }
}
