//
//  MenuViewController.swift
//  My Fancy Room
//
//  Created by Yannick Jacques on 2016-06-19.
//  Copyright © 2016 Yannick Jacques. All rights reserved.
//

import UIKit


@objc protocol menuDelegate {
    
    func cancelItem(key:String)
    func viewOrders()
}

@objc protocol logoutDelegate {
    
    func didLogout()
}

class MenuViewController: UITableViewController {

    
    weak var logoutdelegate:logoutDelegate!
    weak var menudelegate:menuDelegate!
    var mode = 0
    
    var orders:[String] = []
    var ordersKey:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.registerNib(UINib(nibName: "sideMenuCell",bundle: nil), forCellReuseIdentifier: "Cell")
        
        self.view.backgroundColor = UIColor.clearColor()
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
        
        if mode == 0{
        return 2
        }
        return orders.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...
        
        if mode == 0 {
        if indexPath.row == 0 {
            
            cell.textLabel?.text = "My Orders"
        }
        
        if indexPath.row == 1 {
            
            cell.textLabel?.text = "Logout"
        }
        }
        
        else {
            cell.accessoryType = .None
            cell.textLabel?.text = self.orders[indexPath.row]
        }

        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 1  && self.mode == 0{
            
            if self.logoutdelegate != nil {
                self.logoutdelegate.didLogout()
            }
        }
        
        if indexPath.row == 0 && self.mode == 0{
            
            if self.menudelegate != nil {
                self.menudelegate.viewOrders()
            }
        }

    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        if mode != 0 {
            
            return [UITableViewRowAction(style: .Default, title: "Cancel", handler: { (action, indexpath) in
                
                let k = self.ordersKey[indexPath.row]
                self.orders.removeAtIndex(indexPath.row)
                self.ordersKey.removeAtIndex(indexPath.row)
                
                if self.menudelegate != nil {
                    
                    self.tableView.reloadData()
                    self.menudelegate.cancelItem(k)
                    
                }
            })]
        }
        
        return []
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
