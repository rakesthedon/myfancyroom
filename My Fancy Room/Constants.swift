//
//  Constants.swift
//  My Fancy Room
//
//  Created by Yannick Jacques on 2016-06-18.
//  Copyright © 2016 Yannick Jacques. All rights reserved.
//

import Foundation
import UIKit

let ANIMATIONDURATION = 0.5
let MENUCELLID = "MenuCell"
let MENUCELLNIB = "menuCell"

let PROFILECELLID = "ProfileCell"
let PROFILECELLNIB = "profileCell"

let OPTIONCELLID = "OptionCell"
let OPTIONCELLNIB = "OptionCell"

let OPTIONCELLPLUSID = "OptionCellPlus"
let OPTIONCELLPLUSNIB = "OptionCellPlus"



let FOODOPTION = 0
let FOODMENUOPTION = 10
let CLOTHEOPTION = 1
let CLOTHEMENUOPTION = 11
let AMENITIESOPTION = 2


func initOptions() -> OptionViewController{

    
    let ST = UIStoryboard(name: "Option", bundle: nil).instantiateInitialViewController() as! OptionViewController
    
    return ST
}
