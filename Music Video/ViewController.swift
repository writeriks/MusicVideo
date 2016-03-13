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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //Call Api
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
        
    }

    func didLoadData(videos:[Videos]){
        // print(result)
        self.videos = videos
        
        for item in videos{
        print("name = \(item.vName)")
        }
        
        for (index, item) in videos.enumerate(){
            print("\(index) name = \(item.vName)")
        }
    }

}