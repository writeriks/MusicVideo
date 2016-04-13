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
        musicTitle.text = video?.vName
        rank.text = ("\(video!.vRank)") // toString()
        musicImage.image = UIImage(named: "imageNotAvailable")
    }
}
