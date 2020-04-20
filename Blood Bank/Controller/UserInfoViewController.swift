//
//  UserInfoViewController.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 18/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import Firebase

class UserInfoViewController: UIViewController {
    
    
    
   // let ref: DatabaseReference!
    let ref = Database.database().reference()
    
    @IBOutlet var txt_Name: UITextField!
    @IBOutlet var txt_PhoneNo: UITextField!
    @IBOutlet var txt_Email: UITextField!
    @IBOutlet var txt_BloodType: UITextField!
    @IBOutlet var txt_Gender: UITextField!
    @IBOutlet var txt_DOB: UITextField!
    @IBOutlet var txt_lastBD: UITextField!
    @IBOutlet var txt_Area: UITextField!
    @IBOutlet var txt_Disease: UITextField!
    
    var user_Id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveUserData()
    }
    
    func retrieveUserData(){
        
        
        let userID = Auth.auth().currentUser?.uid ?? "error"
        print("\(user_Id)==========================================================")
        let userDatabase = Database.database().reference().child("user: \(userID)")
        userDatabase.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            self.txt_Name.text = snapshotValue["Name"]!
            self.txt_PhoneNo.text = snapshotValue["Phone No"]!
            self.txt_Email.text = snapshotValue["Email"]!
            self.txt_BloodType.text = snapshotValue["Blood Type"]!
            self.txt_Gender.text = snapshotValue["Gender"]!
            self.txt_DOB.text = snapshotValue["Date Of Birth"]!
            self.txt_lastBD.text = snapshotValue["Last Blood Donate"]!
            self.txt_Area.text = snapshotValue["Area"]!
            self.txt_Disease.text = snapshotValue["Blood disease"]!
        }     
        
    }
  

}
