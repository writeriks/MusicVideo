//
//  ViewController.swift
//  Music Video
//
//  Created by Emir haktan Ozturk on 28/02/16.
//  Copyright © 2016 Emir haktan Ozturk. All rights reserved.
//
 
import UIKit

class ViewController: UIViewController {
    
    var videos = [Videos]()
    
    @IBOutlet var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        reachabilityStatusChanged()
        
        
        //Call Api
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
        
        
        
    }

    func didLoadData(videos:[Videos]){
        // print(result)
        
        print(reachabilityStatus)
        
        self.videos = videos
        
        for item in videos{
        print("name = \(item.vName)")
        }
        
        for (index, item) in videos.enumerate(){
            print("\(index) name = \(item.vName)")
        }
    }

    func reachabilityStatusChanged(){
        switch reachabilityStatus{
        case NOACCESS : view.backgroundColor = UIColor.redColor()
        displayLabel.text = "No Internet"
        case WIFI : view.backgroundColor = UIColor.greenColor()
        displayLabel.text =  "Wifi Available"
        case WWAN : view.backgroundColor = UIColor.yellowColor()
        displayLabel.text = "WWAN Available"
        default:return
        }
    }
    
    deinit{
    NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }
    
}