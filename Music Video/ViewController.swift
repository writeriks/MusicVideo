//
//  ViewController.swift
//  Music Video
//
//  Created by Emir haktan Ozturk on 28/02/16.
//  Copyright © 2016 Emir haktan Ozturk. All rights reserved.
//
 
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        //Call Api
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
        
    }

    func didLoadData(result:String){
        // print(result)
        let alert = UIAlertController(title: (result), message: nil, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Default){action -> Void in
        // do sth
        }
        
        alert.addAction(okAction)
        self.presentViewController(alert, animated:true,completion: nil)
        

    }

}