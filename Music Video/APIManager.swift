//
//  APIManager.swift
//  Music Video
//
//  Created by Emir haktan Ozturk on 10/03/16.
//  Copyright © 2016 Emir haktan Ozturk. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString:String, completion:(result:String) -> Void){
    
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        
        let url = NSURL(string: urlString)!  // url i al
        
        let task = session.dataTaskWithURL(url) { // url ile task oluştur içinde data, response ve error olsun
        (data, response, error) -> Void in
            
            if error != nil {
                dispatch_async(dispatch_get_main_queue()){  // hata internet bağlantı hatası
                completion(result: (error!.localizedDescription))
                }
            } else{
                print(data) // data yı log da göster
                /* 
                aşağıda daha önce getirilen NSData Json verisine çevriliyor bunun için do catch bloğu kullanılıyor
                */
                do{
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                        as? JSONDictionary{  //[String: AnyObject] //gelen objeyi json serialization yap
                        print(json)
                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            dispatch_async(dispatch_get_global_queue(priority, 0)){ //global queue
                                dispatch_async(dispatch_get_main_queue()){
                                completion(result: "JSon Serialization Succesfull")
                                }
                            }
                    }
                }catch{
                    dispatch_async(dispatch_get_main_queue()){
                        completion(result: "error in Json Serialization")
                    }
                }
            }
        }
        task.resume()
    }
}