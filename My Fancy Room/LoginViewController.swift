//
//  LoginViewController.swift
//  My Fancy Room
//
//  Created by Yannick Jacques on 2016-06-18.
//  Copyright © 2016 Yannick Jacques. All rights reserved.
//

import UIKit
import SVProgressHUD
import ENSwiftSideMenu
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var loginView: UIView!
    
    var mainView:ENSideMenuNavigationController!
    var sideMenu:MenuViewController!
    
    let BASE_URL = "https://project-7504685312586081255.firebaseio.com/"
    var BASE_REF:FIRDatabaseReference!
    var USER_REF:FIRDatabaseReference!
    var ORDER_REF:FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loginView.alpha = 0.0
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor.whiteColor().CGColor
        loginButton.layer.cornerRadius = 5
        self.loginButton.enabled = false
        
        
        self.BASE_REF = FIRDatabase.database().referenceFromURL(BASE_URL)
        self.USER_REF = FIRDatabase.database().referenceFromURL("\(BASE_URL)/users")
        self.ORDER_REF = FIRDatabase.database().referenceFromURL("\(BASE_URL)/orders")
        
        
        emailTF.attributedPlaceholder = NSAttributedString(string: "email...", attributes: [NSForegroundColorAttributeName:UIColor.lightGrayColor()])
        passwordTF.attributedPlaceholder = NSAttributedString(string: "password...", attributes: [NSForegroundColorAttributeName:UIColor.lightGrayColor()])
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(ANIMATIONDURATION, animations: {
            
            self.loginView.alpha = 1
            
            }) { (done) in
                self.loginButton.enabled = true
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


extension LoginViewController {
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}

extension LoginViewController {
    
    @IBAction func loginInAction(){
        
        NSLog("Loging in")
        
        UIView.animateWithDuration(ANIMATIONDURATION, animations: {
            
            self.loginView.alpha = 0
            
        }) { (done) in
            self.loginButton.enabled = false
            
            SVProgressHUD.setDefaultMaskType(.Clear)
            SVProgressHUD.setDefaultStyle(.Custom)
            SVProgressHUD.setBackgroundColor(UIColor.clearColor())
            SVProgressHUD.setForegroundColor(UIColor.whiteColor())
            
            SVProgressHUD.show()
            
            
            self.login(self.emailTF.text!, password: self.passwordTF.text!, completionBlock: {
            
                NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: #selector(self.gotoMenu), userInfo: nil, repeats: false)
            })
            
            
        }
        
    }
    
    func gotoMenu(){
        
        let st = UIStoryboard(name: "Main", bundle: nil)
        let nav = st.instantiateInitialViewController() as! ENSideMenuNavigationController
        
        let menu = MenuViewController()
        menu.logoutdelegate = self
        nav.sideMenu = ENSideMenu(sourceView: nav.view, menuViewController: menu, menuPosition: .Left, blurStyle: .Dark)
        //MenuViewController()
        
        self.mainView = nav
            self.presentViewController(nav, animated: true) {
            menu.menudelegate = nav.childViewControllers[0] as! ViewController
        }
    }
}


extension LoginViewController {
    
    func login(email:String, password:String, completionBlock:() -> Void) {
        FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (user, error) -> Void in
            if error == nil {
                
                completionBlock()
            }
            else {
                
            }
            
        })
    }
    
    func logout(userId:String) {
        try! FIRAuth.auth()?.signOut()
    }
}

extension LoginViewController:logoutDelegate {
    
    func didLogout(){
        
        self.logout((FIRAuth.auth()?.currentUser?.uid)!)
        self.mainView.dismissViewControllerAnimated(true) { 
            
        }
    }
}