//
//  Theme.swift
//  My Fancy Room
//
//  Created by Yannick Jacques on 2016-06-18.
//  Copyright © 2016 Yannick Jacques. All rights reserved.
//

import Foundation
import UIKit


struct ThemeManager{
    
    static func applyTheme() {
    
        
        // 2
        let sharedApplication = UIApplication.sharedApplication()
        
        sharedApplication.delegate?.window??.tintColor = UIColor.whiteColor()
        
        
        
        
        
        //UITextField.appearance().backgroundColor = theme.backgroundColor
        
        //UITextField.appearance().tintColor = theme.textColor
        
        UINavigationBar.appearance().barStyle = .Black
        UINavigationBar.appearance().translucent   = true
        UINavigationBar.appearance().opaque   = true
        UINavigationBar.appearance().barTintColor = UIColor.clearColor()
        
        UISearchBar.appearance().barTintColor = UIColor.darkGrayColor()
        
    }
}