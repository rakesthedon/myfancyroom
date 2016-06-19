//
//  ViewController.swift
//  PyfBackend
//
//  Created by Kim L on 2016-06-18.
//  Copyright © 2016 Kim L. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    
    let BASE_URL = "https://project-7504685312586081255.firebaseio.com/"
    var BASE_REF:FIRDatabaseReference!
    var USER_REF:FIRDatabaseReference!
    var ORDER_REF:FIRDatabaseReference!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.BASE_REF = FIRDatabase.database().referenceFromURL(BASE_URL)
        self.USER_REF = FIRDatabase.database().referenceFromURL("\(BASE_URL)/users")
        self.ORDER_REF = FIRDatabase.database().referenceFromURL("\(BASE_URL)/orders")
        // Do any additional setup after loading the view, typically from a nib.
        self.button.tintColor = UIColor.redColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func buttonAction(sender: AnyObject) {
        
        //addUser("Kim", lastName: "Ly", email: "contact@kimsangly.com", password: "Abcd1234", phoneNumber: "514-555-1234")
        login("contact@kimsangly.com", password:"Abcd1234")
        getCurrentUserPreferences()
    }
    
    
    //---------- FUNCTIONS
    
    func login(email:String, password:String) {
        FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { (user, error) -> Void in
            if error == nil {
                
            }
            else {
                
            }
            
        })
    }
    
    func logout(userId:String) {
        try! FIRAuth.auth()?.signOut()
    }
    
    func addUser(firstName:String, lastName:String, email:String, password:String, phoneNumber:String) {
        let user = ["firstName": firstName,
            "lastName": lastName,
            "email": email,
            "phoneNumber": phoneNumber]
        FIRAuth.auth()?.createUserWithEmail(email, password: password) { (userInfo, error) in
            if error == nil {
                self.USER_REF.child(userInfo!.uid).setValue(user)
            }
            else {
                NSLog(error.debugDescription)
            }
        }
        
    }
    
    func getCurrentUserPreferences() {
        self.USER_REF.child((FIRAuth.auth()?.currentUser!.uid)!).child("preferences").queryOrderedByValue().observeEventType(.Value, withBlock: { snapshot in
                NSLog("key: %@", snapshot.key)
        })
    }
    
    func addPreference(category:String, preference:String, answer:String) {
        let preference = ["preference": preference,
            "answer": answer
        ]
        self.USER_REF.child((FIRAuth.auth()?.currentUser!.uid)!).child("preferences").setValue(preference)
    }
    
    func order(item:String, quantity:Int) {
        let order = ["item": item,
            "quantity": quantity
        ]
        self.USER_REF.child((FIRAuth.auth()?.currentUser!.uid)!).child("orders").childByAutoId().setValue(order)
    }
    
    func cancelOrder(orderId:String) {
        self.USER_REF.child((FIRAuth.auth()?.currentUser!.uid)!).child("orders").child(orderId).removeValue()
    }
    
    func getCurrentUserOrders(userId:String) {
        self.USER_REF.child((FIRAuth.auth()?.currentUser!.uid)!).child("orders").queryOrderedByValue().observeEventType(.ChildAdded, withBlock: { snapshot in
            NSLog("key: %@", snapshot.key)
        })
    }
}

