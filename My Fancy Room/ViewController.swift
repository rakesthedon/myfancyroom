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
    
    var menuOptions = ["Food","Clothes","Amenities"]
    var menuIcons = [FAType.FACutlery,FAType.FAUserSecret,FAType.FATint]
    
    let PROFILESECTION = 0
    let OPTIONSECTION = 1
    
    var foodSelection:OptionViewController!
    var foodMenuSelection:OptionViewController!
    var clothSelection:OptionViewController!
    var clothMenuSelection:OptionViewController!
    var amenitiesSelection:OptionViewController!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.togglemenuButton.setFAIcon(FAType.FAList, iconSize: 17.0)
        self.sidemenuController = self.navigationController as! ENSideMenuNavigationController
        
        
        self.collectionview.registerNib(UINib(nibName: MENUCELLNIB, bundle:  nil), forCellWithReuseIdentifier: MENUCELLID)
        self.collectionview.registerNib(UINib(nibName: PROFILECELLNIB, bundle:  nil), forCellWithReuseIdentifier: PROFILECELLID)
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        let vieww = UIView()
        vieww.frame = (self.navigationController?.view.frame)!
        vieww.backgroundColor = UIColor.blackColor()
        vieww.alpha = 0.7
        self.navigationController!.view.insertSubview(vieww, atIndex: 0)
        let backgroundView = UIImageView()
        backgroundView.frame = (self.navigationController?.view.frame)!
        backgroundView.image = UIImage(named: "background_1")
        backgroundView.contentMode = .ScaleAspectFill
        
        self.view.backgroundColor = UIColor.clearColor()
        
        self.navigationController!.view.insertSubview(backgroundView, atIndex: 0)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        SVProgressHUD.dismiss()
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.375, animations: {
            
            self.view.alpha = 1.0
        }) { (done) in
            
        }
    }
    @IBAction func toggleSideMenuAction(sender: AnyObject) {
        
        if self.sidemenuController.sideMenu != nil {
            self.sidemenuController.toggleSideMenuView()
        }
    }
}

extension ViewController{
    
    func isProfileSection(section:Int) -> Bool{ return section == PROFILESECTION }
    
    func isOptionSection(section:Int) -> Bool{ return section == OPTIONSECTION }
    
    func isFoodCell(indexPath:NSIndexPath) -> Bool { return isOptionSection(indexPath.section) && indexPath.row == FOODOPTION }
    
    func isClothesCell(indexPath:NSIndexPath) -> Bool { return isOptionSection(indexPath.section) && indexPath.row == CLOTHEOPTION }
    
    func isAmenitiesCell(indexPath:NSIndexPath) -> Bool { return isOptionSection(indexPath.section) && indexPath.row == AMENITIESOPTION }
    
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
            cell.layer.borderColor = UIColor.lightGrayColor().CGColor
            cell.layer.borderWidth = 0.5
            
            
            
            return cell
        }
        
        let cell = self.collectionview.dequeueReusableCellWithReuseIdentifier(MENUCELLID, forIndexPath: indexPath) as! MenuCell
        
        cell.titleLabel.text = self.menuOptions[indexPath.row]
        cell.iconView.setFAIconWithName(self.menuIcons[indexPath.row], textColor: UIColor.whiteColor())
        
        
        //        cell.iconView.layer.borderColor = UIColor.lightGrayColor().CGColor
        //        cell.iconView.layer.borderWidth = 0.5
        //        cell.iconView.layer.masksToBounds = true
        //        cell.iconView.layer.cornerRadius = 5.0
        
        return cell
    }
    
    func collectionView(collectionView : UICollectionView,layout collectionViewLayout:UICollectionViewLayout,sizeForItemAtIndexPath indexPath:NSIndexPath) -> CGSize
    {
        
        
        let w = self.collectionview.frame.size.width - 2
        
        
        if isProfileSection(indexPath.section){
            
            return CGSize(width: w + 2, height: 125)
        }
        
        let ww = w / 3 - 5
        
        let cellSize:CGSize = CGSizeMake(ww - 5, ww - 5 )
        return cellSize
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if isFoodCell(indexPath) {
            self.gotoOption(FOODOPTION)
        }
        
        if isClothesCell(indexPath){
            
            self.gotoOption(CLOTHEOPTION)
        }
        
        if isAmenitiesCell(indexPath){
            
            self.gotoOption(AMENITIESOPTION)
        }
    }
    
    
}


extension ViewController{
    
    func gotoOption(mode:Int){
        
        let optionSelector = OptionViewController()
        
        optionSelector.contentMode = mode
        optionSelector.delegate = self
        switch (mode){
        case FOODOPTION:
            optionSelector.optionTitles = ["Alcohol", "Beverages", "Snacks"]
            optionSelector.picturesTitle = ["alcohol","drinks","snacks"]
            optionSelector.descriptions = ["Grab a drink and relax","Quench your thirst","Craving for some treat? We have what you want"]
            
            self.foodSelection = optionSelector
            break;
        case CLOTHEOPTION:
            optionSelector.optionTitles = ["Suit Rental", "Casual Clothes","Underwear"]
            optionSelector.descriptions = ["Need to look fancy?","For when you want to look and feel good","Forgot something at home?"]
            optionSelector.picturesTitle = ["tuxedos","clothes","underwear"]
            
            self.clothSelection = optionSelector
            break;
            
        case AMENITIESOPTION:
            optionSelector.mode = 1
            optionSelector.optionTitles = ["Extra Pillows","Blankets", "Toothpaste", "Toothbrush", "Dental Floss", "Shampoo", "Conditionner", "Lotion"]
            
            self.amenitiesSelection = optionSelector
            break;
        default:break;
        }
        
        UIView.animateWithDuration(0.375, animations: {
            self.view.alpha = CGFloat(0.0)
            }, completion: { (done) in
                self.sidemenuController.pushViewController(optionSelector, animated: false)
        })
    }
}

extension ViewController:optionSelectionDelegate{
    
    func optionviewController(option: OptionViewController, optionChosen text: String) {
        
        self.navigationController?.popViewControllerAnimated(false)
        
        if self.foodSelection != nil && option == self.foodSelection {
            self.foodMenuSelection = OptionViewController()
            self.foodMenuSelection.delegate = self
            
            
            if text ==  "Snacks"{
                self.foodMenuSelection.optionTitles = ["French Fries","Seasoned Vegetables","Plain Pizza","Steak"]
            }
            
            if text ==  "Alcohol"{
                self.foodMenuSelection.optionTitles = ["Cabernet Sauvignon","Malbec","Pinot Noir","Pinot Grigio"]
            }
            
            if text ==  "Beverages"{
                self.foodMenuSelection.optionTitles = ["1L Evian","33cL Soda Can","1L Sparkling Water"]
            }
            
            self.foodMenuSelection.mode = self.foodMenuSelection.LISTMODE
            self.navigationController?.pushViewController(self.foodMenuSelection, animated: false)
            
        }
        
        
        if self.clothSelection != nil && option == self.clothSelection {
            
            self.clothMenuSelection = OptionViewController()
            self.clothMenuSelection.delegate = self
            
            if text == "Suit Rental"{
                self.clothMenuSelection.optionTitles = ["Black Tuxedo","Blazer","Dressed Choose"]
            }
            
            if text == "Casual Clothes" {
                self.clothMenuSelection.optionTitles = ["Shirt","Denim Pants","Casual Dress"]
            }
            
            if text == "Unverwear" {
                self.clothMenuSelection.optionTitles = ["Boxer Shorts","Boxer Briefs","Trunks"]
                
            }
            self.clothMenuSelection.mode = self.clothMenuSelection.LISTMODE
            self.navigationController?.pushViewController(self.clothMenuSelection, animated: false)
        }
        
        
    }
}
