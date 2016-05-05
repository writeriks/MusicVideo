//
//  MusicVideoDetailVC.swift
//  Music Video
//
//  Created by Emir haktan Ozturk on 18/04/16.
//  Copyright © 2016 Emir haktan Ozturk. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MusicVideoDetailVC: UIViewController {

    var videos:Videos!
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var vName: UILabel!
    @IBOutlet var vGenre: UILabel!
    @IBOutlet var vPrice: UILabel!
    @IBOutlet var vRights: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = videos.vArtist
        vName.text = videos.vName
        vPrice.text = videos.vPrice
        vGenre.text = videos.vGenre
        vRights.text = videos.vRights
        if videos.vImageData != nil {
            imageView.image = UIImage(data: videos.vImageData!)
        }
        else{
            imageView.image = UIImage(named: "imageNotAvailable")
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "prefferedFontChange", name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
    
    @IBAction func playVideo(sender: UIBarButtonItem) {
        
        let url = NSURL(string: videos.vVideoUrl)!
        let player = AVPlayer(URL: url)
        let playerVievController = AVPlayerViewController()
        playerVievController.player = player
        self.presentViewController(playerVievController, animated: true){
            playerVievController.player?.play()
        }
        
    }
    
    func prefferedFontChange(){
        print("preferred font changed")
        vName.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        vPrice.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        vGenre.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        vRights.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name:UIContentSizeCategoryDidChangeNotification, object: nil)
    }
}
