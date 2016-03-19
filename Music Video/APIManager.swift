//
//  APIManager.swift
//  Music Video
//
//  Created by Emir haktan Ozturk on 10/03/16.
//  Copyright © 2016 Emir haktan Ozturk. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString:String, completion:[Videos] -> Void){
    
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        
        let url = NSURL(string: urlString)!  // url i al
        
        let task = session.dataTaskWithURL(url) { // url ile task oluştur içinde data, response ve error olsun
        (data, response, error) -> Void in
            
            if error != nil {
                
                    print(error!.localizedDescription)
                
            } else{
                /* 
                aşağıda daha önce getirilen NSData Json verisine çevriliyor bunun için do catch bloğu kullanılıyor
                */
                do{
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary,  //[String: AnyObject] //gelen objeyi json serialization yap
                            feed = json["feed"] as? JSONDictionary,
                            entries = feed["entry"] as? JSONArray {
                            
                                var videos = [Videos]()
                                for entry in entries{
                                    let entry = Videos(data: entry as! JSONDictionary)// Videos class ındaki init metodunun içine etryleri atıp entrynin içine attı
                                    videos.append(entry)
                                }
                                let i = videos.count
                                print("iTunes Api Manager - total count ----> \(i)")
                                print("")
                                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                                dispatch_async(dispatch_get_global_queue(priority, 0)){
                                    dispatch_async(dispatch_get_main_queue()){
                                    completion(videos)
                                }
                            }
                    }
                }catch{
                        print("error in Json Serialization")
                    }
                }
            }
        task.resume()
    }
}