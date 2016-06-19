//
//  OptionViewController.swift
//  My Fancy Room
//
//  Created by Yannick Jacques on 2016-06-18.
//  Copyright © 2016 Yannick Jacques. All rights reserved.
//

import UIKit


@objc protocol optionSelectionDelegate{
    
    func optionviewController(option:OptionViewController, optionChosen text:String)
    
    func optionviewController(option:OptionViewController, order items:[String:Int])
}

class OptionViewController: UITableViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    weak var delegate:optionSelectionDelegate!
    var optionTitles:[String] = []
    var picturesTitle:[String] = []
    var descriptions: [String] = []
    var cachedPictures:[String:UIImage] = [:]
    
    var order:[String:Int] = [:]
    
    let LISTMODE = 1
    let FANCYMENUMODE = 0
    
    var mode:Int = 0
    var contentMode = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let background = UIImageView(frame: self.view.frame)
        //        background.image = UIImage(named: "background")
        //        background.alpha = 0.7
        //        self.view.backgroundColor = UIColor.blackColor()
        //
        //        self.view.addSubview(background)
        
        self.view.alpha = 0.0
        self.view.bringSubviewToFront(self.tableView)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //self.tableView.allowsSelection = false
        self.view.backgroundColor = UIColor.blackColor()
        self.tableView.backgroundColor = UIColor.blackColor()
        self.tableView.registerNib(UINib(nibName: OPTIONCELLNIB, bundle: nil), forCellReuseIdentifier: OPTIONCELLID)
        
        self.tableView.registerNib(UINib(nibName: "cell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        
        
        self.tableView.scrollEnabled = true
        
        self.doneButton.title = "Done"
        self.doneButton.enabled = true
        if self.mode == FANCYMENUMODE{
            
            self.tableView.scrollEnabled = false
            self.doneButton.title = ""
            self.doneButton.enabled = false
        }
        
        if self.mode == LISTMODE {
            
            self.tableView.backgroundColor = UIColor.clearColor()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        UIView.animateWithDuration(0.375, animations: {
            
            self.view.alpha = 1.0
        }) { (done) in
            
        }
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        
        
        
        UIView.animateWithDuration(0.375, animations: {
            self.view.alpha = 0
        }) { (done) in
            
            self.navigationController?.popViewControllerAnimated(false)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return optionTitles.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if self.mode == FANCYMENUMODE{
            let cell = tableView.dequeueReusableCellWithIdentifier(OPTIONCELLID, forIndexPath: indexPath) as! OptionCell
            
            
            
            
            if self.cachedPictures[self.picturesTitle[indexPath.row]] != nil {
                
                cell.customImageView.image = self.cachedPictures[self.picturesTitle[indexPath.row]]
            }
                
            else {
                
                self.cachedPictures[self.picturesTitle[indexPath.row]] = UIImage(named: self.picturesTitle[indexPath.row])
                cell.customImageView.image = self.cachedPictures[self.picturesTitle[indexPath.row]]
            }
            
            cell.titleLabel.text = self.optionTitles[indexPath.row]
            cell.descriptionLabel.text = self.descriptions[indexPath.row]
            cell.titleLabel.numberOfLines = 0
            cell.titleLabel.sizeToFit()
            
            
            
            //cell.bringSubviewToFront(cell.titleLabel)
            return cell
        }
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! OptionCell
        cell.backgroundColor = UIColor.clearColor()
        cell.delegate = self
        cell.titleLabel?.text = self.optionTitles[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
        if self.mode == FANCYMENUMODE {
            let h = (self.tableView.frame.height - (self.navigationController?.navigationBar.frame.height)! - UIApplication.sharedApplication().statusBarFrame.height)
            
            let hh = h / CGFloat(self.descriptions.count > 0 ? self.descriptions.count : 1)
            
            return hh
        }
        else {
            
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        if contentMode != AMENITIESOPTION {
            return true
        }
        return false
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //        if contentMode != AMENITIESOPTION {
        //
        //            let option = OptionViewController()
        //            option.mode = LISTMODE
        //            if contentMode == FOODOPTION{
        //
        //                if indexPath.row == 0{
        //                    option.optionTitles = ["Carbet Sauvignon, $29","Pinot Grigio, $34","Chardonnay"]
        //                }
        //            }
        //
        //            self.navigationController?.pushViewController(option, animated: true)
        //        }
        
        if self.delegate != nil && self.mode == FANCYMENUMODE{
            
            let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! OptionCell
            
            self.delegate.optionviewController(self, optionChosen: cell.titleLabel.text!)
        }
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension OptionViewController:orderDelegate{
    
    func orderEdit(item: String, quantity:Int) {
        
        self.order[item] = quantity
    }
    
    
    @IBAction func doneAction(sender: UIBarButtonItem) {
        
        if self.delegate != nil {
            
            self.delegate.optionviewController(self, order: self.order)
        }
    }
    
}
