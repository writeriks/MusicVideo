//
//  MusicVideoTVC.swift
//  Music Video
//
//  Created by Emir haktan Ozturk on 28/03/16.
//  Copyright © 2016 Emir haktan Ozturk. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {

    var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Music Videos"
        NotificationCenter.default.addObserver(self, selector: #selector(MusicVideoTVC.reachabilityStatusChanged), name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(MusicVideoTVC.prefferedFontChange), name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
        
        reachabilityStatusChanged()
        
    }
    
    func prefferedFontChange(){
        print("Preferred font changed")
    }
    
    func didLoadData(_ videos:[Videos]){
        // print(result)
        
        print(reachabilityStatus)
        
        self.videos = videos
        for item in videos{
            print("name = \(item.vName)")
        }
        for (index, item) in videos.enumerated(){
            print("\(index) name = \(item.vName)")
        }
        tableView.reloadData()
    }
    
    func reachabilityStatusChanged(){

        switch reachabilityStatus {
        case NOACCESS :
            //view.backgroundColor = UIColor.redColor()
            // move back to Main Queue
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the Internet", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
                    action -> () in
                    print("Cancel")
                }
                
                let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {
                    action -> () in
                    print("delete")
                }
                let okAction = UIAlertAction(title: "ok", style: .default) { action -> Void in
                    print("Ok")
                    
                    //do something if you want
                    //alert.dismissViewControllerAnimated(true, completion: nil)
                }
                
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                alert.addAction(deleteAction)
                
                
                self.present(alert, animated: true, completion: nil)
            }
            
        default:
            //view.backgroundColor = UIColor.greenColor()
            if videos.count > 0 {
                print("do not refresh API")
            } else {
                runAPI()
            }
        }
    }
    
    // MARK: - Call API
    
    func runAPI(){
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=200/json", completion: didLoadData)
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ReachStatusChanged"), object: nil)
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }
    
    fileprivate struct storyboard{
    
        static let cellReuseIdentifier = "cell"
        static let segueIdentifier = "musicDetail"
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 139
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: storyboard.cellReuseIdentifier, for: indexPath) as! MusicVideoTableViewCell
        
        cell.video = videos[(indexPath as NSIndexPath).row]
        

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == storyboard.segueIdentifier{
            if let indexPath = tableView.indexPathForSelectedRow{
                let video =  videos[(indexPath as NSIndexPath).row]
                let dvc = segue.destination as! MusicVideoDetailVC
                dvc.videos = video
            }
        }
    }

}
