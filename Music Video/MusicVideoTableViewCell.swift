//
//  MusicVideoTableViewCell.swift
//  Music Video
//
//  Created by Emir haktan Ozturk on 10/04/16.
//  Copyright © 2016 Emir haktan Ozturk. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {

    var video:Videos?{
        didSet{
            updateCell()
        }
    }
    
    
    @IBOutlet var musicImage: UIImageView!
    
    @IBOutlet var rank: UILabel!
    
    
    @IBOutlet var musicTitle: UILabel!
    
    
    func updateCell(){
        musicTitle.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        rank.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        musicTitle.text = video?.vName
        rank.text = ("\(video!.vRank)") // toString()
        
        //musicImage.image = UIImage(named: "imageNotAvailable")
        
        if video!.vImageData != nil {
            print("getting data from array")
            musicImage.image = UIImage(data: video!.vImageData!)
        }else{
          getVideoImage(video!, imageView: musicImage)
        }
    }
    
    func getVideoImage(video:Videos, imageView : UIImageView){
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)){

            let data = NSData(contentsOfURL: NSURL(string: video.vImageUrl)!)
            
            var image : UIImage?
            
            if data != nil{
                video.vImageData = data
                image = UIImage(data: data!)
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = image
            }
        }

    }
    
    
}
