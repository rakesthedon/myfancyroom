//
//  ViewController.swift
//  My Fancy Room
//
//  Created by Yannick Jacques on 2016-06-18.
//  Copyright © 2016 Yannick Jacques. All rights reserved.
//

import UIKit
import SVProgressHUD
import ENSwiftSideMenu
import Font_Awesome_Swift

class ViewController: UIViewController {

    @IBOutlet weak var togglemenuButton: UIBarButtonItem!
    
    var sidemenuController:ENSideMenuNavigationController!
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    var menuOptions = ["Food","Clothes","amenities"]
    var menuIcons = [FAType.FACutlery,FAType.FAUserSecret,FAType.FATint]
    
    let PROFILESECTION = 0
    let OPTIONSECTION = 1
    
    
    let FOODOPTION = 0
    let CLOTHEOPTION = 1
    let AMENITIESOPTION = 2
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.togglemenuButton.setFAIcon(FAType.FAList, iconSize: 17.0)
        self.sidemenuController = self.navigationController as! ENSideMenuNavigationController
        
        
        self.collectionview.registerNib(UINib(nibName: MENUCELLNIB, bundle:  nil), forCellWithReuseIdentifier: MENUCELLID)
        self.collectionview.registerNib(UINib(nibName: PROFILECELLNIB, bundle:  nil), forCellWithReuseIdentifier: PROFILECELLID)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        SVProgressHUD.dismiss()
    }
    @IBAction func toggleSideMenuAction(sender: AnyObject) {
        
        if self.sidemenuController.sideMenu != nil {
            self.sidemenuController.toggleSideMenuView()
        }
    }
}

extension ViewController{
    
    func isProfileSection(section:Int) -> Bool{
        
        return section == PROFILESECTION
    }
    
    func isOptionSection(section:Int) -> Bool{
        
        return section == OPTIONSECTION
    }
    
    func isFoodCell(indexPath:NSIndexPath) -> Bool {
        
        return isOptionSection(indexPath.section) && indexPath.row == FOODOPTION
    }
    
    func isClothesCell(indexPath:NSIndexPath) -> Bool {
        
        return isOptionSection(indexPath.section) && indexPath.row == CLOTHEOPTION
    }
    
    func isAmenitiesCell(indexPath:NSIndexPath) -> Bool {
        
        return isOptionSection(indexPath.section) && indexPath.row == AMENITIESOPTION
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        
        
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        if isProfileSection(section) { return 1 }
        return self.menuOptions.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if isProfileSection(indexPath.section) {
            
            let cell = self.collectionview.dequeueReusableCellWithReuseIdentifier(PROFILECELLID, forIndexPath: indexPath)
            
            return cell
        }
        
        let cell = self.collectionview.dequeueReusableCellWithReuseIdentifier(MENUCELLID, forIndexPath: indexPath) as! MenuCell
        
        cell.titleLabel.text = self.menuOptions[indexPath.row]
        cell.iconView.setFAIconWithName(self.menuIcons[indexPath.row], textColor: UIColor.whiteColor())
        return cell
    }
    
    func collectionView(collectionView : UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize
    {
        
        
        let w = self.collectionview.frame.size.width - 2
        
        
        if isProfileSection(indexPath.section){
            
                return CGSize(width: w, height: 125)
        }
        
        let ww = w / 3 - 5
        
        let cellSize:CGSize = CGSizeMake(ww - 5, ww - 5 )
        return cellSize
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if isFoodCell(indexPath) {
            
        }
        
        if isClothesCell(indexPath){
            
        }
        
        if isAmenitiesCell(indexPath){
            
        }
    }
}

