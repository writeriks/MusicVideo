//
//  ViewController.swift
//  Music Video
//
//  Created by Emir haktan Ozturk on 28/02/16.
//  Copyright © 2016 Emir haktan Ozturk. All rights reserved.
//
 
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var videos = [Videos]()

    @IBOutlet var tableView: UITableView!
    @IBOutlet var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self//datasource ve delegate VC ye bağlandı
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
        
        
        //Call Api
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json", completion: didLoadData)
        
        
        
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
        
        tableView.reloadData()
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return videos.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let video = videos[indexPath.row]
        cell.textLabel?.text = ("\(indexPath.row + 1)")
        cell.detailTextLabel?.text = video.vName
        
        return cell
    }
    
    
    
    
    
    
}