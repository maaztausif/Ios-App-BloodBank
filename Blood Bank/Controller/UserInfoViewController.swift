//
//  UserInfoViewController.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 18/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


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
        view.backgroundColor = UIColor.flatCoffee()
    }
    
    func retrieveUserData(){
        
        
        let userID = Auth.auth().currentUser?.uid ?? "error"
        
        print("\(userID)==========================================================hoko")
        let userDatabase = Database.database().reference().child("user: \(userID)")
        userDatabase.observe(.childAdded) { (snapshot) in
            print(snapshot)
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
    
    
    @IBAction func update(_ sender: Any) {
        let dic  = ["Name":txt_Name.text!,"Area":txt_Area.text!,"Blood Type":txt_BloodType.text!,"Blood disease":txt_Disease.text!,"Date Of Birth":txt_DOB.text!,"Email":txt_Email.text!,"Gender":txt_Gender.text!,"Last Blood Donate":txt_lastBD.text!,"Phone No":txt_PhoneNo.text!]
        
        let userID = Auth.auth().currentUser?.uid ?? "error"
        let db = Database.database().reference()
        db.child("user: \(userID)").setValue(dic) { (error, refrence) in
            if error != nil{
                print("update nai hua")
            }else{
                print("update ho gya he")
            }
        }
        
//        ref.child("users").child(user.uid).setValue(dic) {
//            (error:Error?, ref:DatabaseReference) in
//            if let error = error {
//                print("Data could not be saved: \(error).")
//            } else {
//                print("Data saved successfully!")
//            }
//        }
        
      retrieveUserData()
        
    }
    

}
