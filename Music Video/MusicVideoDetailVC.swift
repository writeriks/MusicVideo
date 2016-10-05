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
            imageView.image = UIImage(data: videos.vImageData! as Data)
        }
        else{
            imageView.image = UIImage(named: "imageNotAvailable")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(MusicVideoDetailVC.prefferedFontChange), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
    }
    
    
    @IBAction func playVideo(_ sender: UIBarButtonItem) {
        
        let url = URL(string: videos.vVideoUrl)!
        let player = AVPlayer(url: url)
        let playerVievController = AVPlayerViewController()
        playerVievController.player = player
        self.present(playerVievController, animated: true){
            playerVievController.player?.play()
        }
        
    }
    
    func prefferedFontChange(){
        print("preferred font changed")
        vName.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        vPrice.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        vGenre.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        vRights.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
    }
}
