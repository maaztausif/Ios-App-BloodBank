//
//  DonarListTableViewController.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 22/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import Firebase
import ChameleonFramework

protocol MyCustomCellDelegator {
    func callSegueFromCell()
    func sendDataFromSegue()
}

class DonarListTableViewController: UITableViewController , MyCustomCellDelegator {
    
    func callSegueFromCell() {
        performSegue(withIdentifier: "goToChat", sender: self )
   }
    func sendDataFromSegue() {
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destinationVC = segue.destination as! ChatViewController
            destinationVC.currentUserName = currentUserName
            destinationVC.otherUserId = otherUserID
            destinationVC.otherUserName = otherUserName
            destinationVC.userId = userID
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ChatViewController
        destinationVC.currentUserName = currentUserName
        destinationVC.otherUserId = otherUserID
        destinationVC.otherUserName = otherUserName
        destinationVC.userId = userID
    }
    
    @IBOutlet var donarTableView: UITableView!
    
    
    var donarListArray = [Donar]()

    var color : String!
    var dic = [String:String]()

    
    var currentUserName = ""
    var userID = ""
    var otherUserName = ""
    var otherUserID = ""
    var userNamesArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
        getNameCurrentUser()
        userID = Auth.auth().currentUser?.uid ?? "error"
        donarTableView.register(UINib(nibName: "DonarListTableViewCell", bundle: nil), forCellReuseIdentifier: "DonarCell")
        retrieveDonarLis()
        tableView.separatorStyle = .none
//        donarTableView.reloadData()

        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175.0;//Choose your custom row height
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return donarListArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DonarCell", for: indexPath) as! DonarListTableViewCell
        cell.delegate = self
        cell.lbl_name.text = donarListArray[indexPath.row].name
        cell.lbl_BloodType.text = donarListArray[indexPath.row].blooadType
        cell.lbl_Gender.text = donarListArray[indexPath.row].gender
        cell.lbl_LastBloodDonate.text = donarListArray[indexPath.row].lastBloodDonate
        cell.txt_phoneNo.text = donarListArray[indexPath.row].phoneNo
        cell.phone_No = donarListArray[indexPath.row].phoneNo
        
        
        cell.currentUserName = currentUserName
        print("\(currentUserName)==================for name")

        cell.userID = userID
        cell.OtherUserName = donarListArray[indexPath.row].name
        print("\(donarListArray[indexPath.row].name)==================In cell")
        otherUserName = donarListArray[indexPath.row].name

        print("\(otherUserName)==================In cell 2 2 2")

        
        if let name = dic[otherUserName]{
            cell.otherUserID = name
            otherUserID = name
            print("\(name)==================In cell 2 2 2")
        }else{
            print("nai chala bhai ===========================")
        }
        
    //cell.backgroundColor = UIColor(hexString: "1D9BF6")

        let colorName = UIColor(hexString: color )

        if let color = colorName?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(17)) {
            cell.backgroundColor = color
            //cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        donarTableView.reloadData()
    }

    
    func retrieveData(){
        let database = Database.database().reference().child("All Users")
        
        database.observe(.childAdded) { (Snapshot) in
            print(Snapshot)
            let snapshotValue = Snapshot.value as! Dictionary<String,String>
            let user_ID1 = snapshotValue["userID"]!
            let userNameDB = database.database.reference().child("user: \(user_ID1)")
            userNameDB.observe(.childAdded, with: { (userSnapShot) in
                let userSnapshotValue = userSnapShot.value as! Dictionary<String,String>
                if let name = userSnapshotValue["Name"] {
                    if self.currentUserName == name{
                    }else{
                        self.dic[name] = user_ID1
                        self.userNamesArray.append(name)
                        print("users dictionary : \(self.dic)==========================")
                        self.donarTableView.reloadData()

                    }
                }
                
                print(self.userNamesArray)
                
            })
            
            
            
            
        }
        
    }
    

    func retrieveDonarLis(){
        let donarDB = Database.database().reference().child("Donar List")
        donarDB.observe(.childAdded) { (Snapshot) in
            print(Snapshot)
            let snapshotValue = Snapshot.value as! Dictionary<String,String>
            let user_Donar = Donar()
            user_Donar.name = snapshotValue["Name"]!
            user_Donar.gender = snapshotValue["Gender"]!
            user_Donar.blooadType = snapshotValue["Blood Type"]!
            user_Donar.lastBloodDonate = snapshotValue["Last Blood Donate"]!
            user_Donar.phoneNo = snapshotValue["Phone No"]!
            //self.color = UIColor.randomFlat().hexValue()
            self.color = UIColor.flatSand()?.hexValue()
            self.donarListArray.append(user_Donar)
            self.donarTableView.reloadData()
        }
    }
    

    
    func getNameCurrentUser(){
        let userID = Auth.auth().currentUser?.uid ?? "error"
        let db = Database.database().reference().child("user: \(userID)")
        db.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            print(snapshot)
            if let currentName = snapshotValue["Name"]{
                self.currentUserName = currentName
                print(" this is current user name : \(self.currentUserName)=======================")
                
            }
            
        }
        
    }


}
