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
    var childID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveUserData()
        view.backgroundColor = UIColor.flatCoffee()
    }
    
    // MARK: - Retrieving data from Database

    
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
        print("\(userID)==========================================================hoko")
        
                Database.database().reference().child("user: \(userID)").observeSingleEvent(of: .value) { (snapshot) in
                    for snap in snapshot.children {
                        let userSnap = snap as! DataSnapshot
                        self.childID = userSnap.key //the uid of each user
                        print("\(self.childID) user keys")
                    }
                }
        
        
 
    }
    
    // MARK: - update Button

    
    @IBAction func update(_ sender: Any) {
        
        let userDic = ["Name":txt_Name.text!,"Email":txt_Email.text!,"Phone No":txt_PhoneNo.text!,"Blood Type":txt_BloodType.text!,"Gender":txt_Gender.text!,"Area":txt_Area.text!,"Date Of Birth":txt_DOB.text!,"Last Blood Donate":txt_lastBD.text!,"Blood disease":txt_Disease.text!]
        
        print(userDic)
        let userID = Auth.auth().currentUser?.uid ?? "error"

        
//        let db = Database.database().reference()
//        db.child("user: \(userID)").setValue(userDic) { (error, refrence) in
//            if error != nil{
//                print("update nai hua")
//            }else{
//                print("update ho gya he")
//            }
//        }
        

        let ref = Database.database().reference().root.child("user: \(userID)").childByAutoId().updateChildValues(userDic) { (error, refrence) in
            if error != nil{
                print("updating error")
                
                let alert = UIAlertController(title: "Error In Update", message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    
                })
                
                alert.addAction(action)
                self.present(alert,animated: true,completion: nil)
                
                
            }else{
                print("no error in update")
                
                let alert = UIAlertController(title: "Update Complete", message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    
                })
                
                alert.addAction(action)
                self.present(alert,animated: true,completion: nil)
                
                
            }
        }

        Database.database().reference(withPath: "user: \(userID)").child(self.childID).removeValue()

        
        
       retrieveUserData()
        
    }
    

}
