//
//  MusicVideoDetailVC.swift
//  Music Video
//
//  Created by Emir haktan Ozturk on 18/04/16.
//  Copyright © 2016 Emir haktan Ozturk. All rights reserved.
//

import UIKit

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
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
