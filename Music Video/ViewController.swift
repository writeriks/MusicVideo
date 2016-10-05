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
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        
        reachabilityStatusChanged()
        
        
        //Call Api
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json", completion: didLoadData)
        
        
        
    }

    func didLoadData(_ videos:[Videos]){
        // print(result)
        
        print(reachabilityStatus)
        
        self.videos = videos
        
        for item in videos{
        print("name = \(item.vName)")
        }
        
        for (index, item) in videos.enumerated(){
            print("\(index) name = \(item.vName)")
        }
        
        tableView.reloadData()
    }

    func reachabilityStatusChanged(){
        switch reachabilityStatus{
        case NOACCESS : view.backgroundColor = UIColor.red
        displayLabel.text = "No Internet"
        case WIFI : view.backgroundColor = UIColor.green
        displayLabel.text =  "Wifi Available"
        case WWAN : view.backgroundColor = UIColor.yellow
        displayLabel.text = "WWAN Available"
        default:return
        }
    }
    
    deinit{
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return videos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let video = videos[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = ("\((indexPath as NSIndexPath).row + 1)")
        cell.detailTextLabel?.text = video.vName
        
        return cell
    }
    
    
    
    
    
    
}
