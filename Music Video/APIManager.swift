//
//  APIManager.swift
//  Music Video
//
//  Created by Emir haktan Ozturk on 10/03/16.
//  Copyright © 2016 Emir haktan Ozturk. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(_ urlString:String, completion:@escaping ([Videos]) -> Void){
    
        let config = URLSessionConfiguration.ephemeral
        
        let session = URLSession(configuration: config)
        
        let url = URL(string: urlString)!  // url i al
        
        let task = session.dataTask(with: url, completionHandler: { // url ile task oluştur içinde data, response ve error olsun
        (data, response, error) -> Void in
            
            if error != nil {
                
                    print(error!.localizedDescription)
                
            } else{
                /* 
                aşağıda daha önce getirilen NSData Json verisine çevriliyor bunun için do catch bloğu kullanılıyor.... 
                json datayı açmak için;
                json objeyi kontrol et
                obje süslü parantez ise json dictionary değilse json array,
                sonra içindeki objeyi kontrol et json array veya json dictionary
                sınıftaki objeye gelene kadar bu işleme devam et
                daha sonra sınıftan bir instance oluştur.
                ulaşılan son objede dön ve instance ın içine at
                */
                do{
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? JSONDictionary,  //[String: AnyObject] //gelen objeyi json serialization yap
                        
                            let feed = json["feed"] as? JSONDictionary,
                            let entries = feed["entry"] as? JSONArray {
                        
                            print(feed)
                            print(entries)
                                var videos = [Videos]()
                                for (index, entry) in entries.enumerated(){
                                    print(entry)
                                    let entry = Videos(data: entry as! JSONDictionary)// Videos class ındaki init metodunun içine etryleri atıp entrynin içine attı
                                    entry.vRank = index + 1
                                    videos.append(entry)
                                }
                                let i = videos.count
                                print("iTunes Api Manager - total count ----> \(i)")
                                print("")
                                let priority = DispatchQueue.GlobalQueuePriority.default
                                DispatchQueue.global(priority: priority).async{
                                    DispatchQueue.main.async{
                                    completion(videos)
                                }
                            }
                    }
                }catch{
                        print("error in Json Serialization")
                    }
                }
            }) 
        task.resume()
    }
}
