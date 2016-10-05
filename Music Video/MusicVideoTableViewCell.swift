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
        musicTitle.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        rank.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        musicTitle.text = video?.vName
        rank.text = ("\(video!.vRank)") // toString()
        
        //musicImage.image = UIImage(named: "imageNotAvailable")
        
        if video!.vImageData != nil {
            print("getting data from array")
            musicImage.image = UIImage(data: video!.vImageData! as Data)
        }else{
          getVideoImage(video!, imageView: musicImage)
        }
    }
    
    func getVideoImage(_ video:Videos, imageView : UIImageView){
        
        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async{

            let data = try? Data(contentsOf: URL(string: video.vImageUrl)!)
            
            var image : UIImage?
            
            if data != nil{
                video.vImageData = data
                image = UIImage(data: data!)
            }
            
            DispatchQueue.main.async {
                imageView.image = image
            }
        }

    }
}
