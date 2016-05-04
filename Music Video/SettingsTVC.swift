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
