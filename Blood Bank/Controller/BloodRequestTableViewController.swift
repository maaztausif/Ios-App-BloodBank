//
//  BloodRequestTableViewController.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 20/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView
import ChameleonFramework
import FirebaseAuth

protocol MyCustomCellDelegatorForRequest {
    func callSegueFromCell()
    func sendDataFromSegue(userName_D : String,otherUserName_D:String,userID_D:String,otherUserID_D:String)
}


class BloodRequestTableViewController: UITableViewController ,NVActivityIndicatorViewable,MyCustomCellDelegatorForRequest{
    func callSegueFromCell() {
        performSegue(withIdentifier: "goToChat", sender: self)
    }
    
    func sendDataFromSegue(userName_D: String, otherUserName_D: String, userID_D: String, otherUserID_D: String) {
        
        print("in segue user name= \(userName_D)")
        print("in segue other user name= \(otherUserName_D)")
        print("in segue other userID= \(otherUserID_D)")
        print("in segue user  id= \(userID_D)")
        
        currentUserName_S = userName_D
        userID_S = userID_D
        otherUserID_S = otherUserID_D
        otherUserName_S = otherUserName_D

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToChat"{
    
            let destinationVC = segue.destination as! ChatViewController
            destinationVC.currentUserName = currentUserName_S
            destinationVC.otherUserId = otherUserID_S
            destinationVC.otherUserName = otherUserName_S
            destinationVC.userId = userID_S
        }
    }
    
    var currentUserName_S = ""
    var userID_S = ""
    var otherUserName_S = ""
    var otherUserID_S = ""
    
    
    var request_Array = [Requests]()
    var color:String = ""
    var userReqDic = [String:String]()
    var currentUserName = ""
    var userID = ""

    @IBOutlet var requestTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getNameCurrentUser()
        
        requestTableView.delegate = self
        requestTableView.dataSource = self
        
        requestTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "RequestCell")
        requestTableView.separatorStyle = .none
        
        self.configureTableView()

        RetrieveMsg()

    }
    
    func configureTableView(){
//        requestTableView.rowHeight = UITableView.automaticDimension
//        requestTableView.estimatedRowHeight = 300.2
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 20.0 // Set this value as a good estimation according to your cells
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return request_Array.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0;//Choose your custom row height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestCell", for: indexPath) as! TableViewCell
        
        cell.delegate = self
        
        cell.lbl_Name.text = request_Array[indexPath.row].name
        cell.lbl_BloodType.text = request_Array[indexPath.row].blood_Type
        cell.lbl_RequestFor.text = request_Array[indexPath.row].request_For
        cell.lbl_Location.text = request_Array[indexPath.row].location
        cell.txt_PhoneNo.text = request_Array[indexPath.row].phoneNo
        cell.phone_No = request_Array[indexPath.row].phoneNo
        
        print("in table view Cell ======= \(currentUserName)")
        
        cell.userName = currentUserName
        cell.userID = userID
        cell.otherUsername = request_Array[indexPath.row].name
        cell.otherUserID = userReqDic[request_Array[indexPath.row].name]!
        
        let colorName = UIColor(hexString: color )
        
        if let color = colorName?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(17)) {
            cell.backgroundColor = color
            //cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        print("\(cell.otherUserID) : otherUserID")
        print("\(cell.userID) : userID")
        print("\(cell.userName) : userName")
        print("\(cell.otherUsername) : otherUserName")
    }
    
    
    func RetrieveMsg(){
        let request_DB = Database.database().reference().child("Blood Request")
        
        request_DB.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let user_Requests = Requests()
            
            user_Requests.name = snapshotValue["Name"]!
            user_Requests.blood_Type = snapshotValue["Blood Type"]!
            user_Requests.request_For = snapshotValue["Request For"]!
            user_Requests.location = snapshotValue["Area"]!
            user_Requests.phoneNo = snapshotValue["Phone No"]!
            self.userReqDic[snapshotValue["Name"]!] = snapshotValue["User ID"]!
            print("\(self.userReqDic) userDic =================")
            self.request_Array.append(user_Requests)
            self.color = UIColor.flatSand().hexValue()
            self.configureTableView()
            self.requestTableView.reloadData()
        }
    }
    
    func progressLoading(){
        let size = CGSize(width: 100, height: 100)
        startAnimating(size, message: "Loading...", type: NVActivityIndicatorType.pacman, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),  textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), fadeInAnimation: nil)
        
    }
 

    func getNameCurrentUser(){
        userID = Auth.auth().currentUser?.uid ?? "error"
        let db = Database.database().reference().child("user: \(userID)")
        db.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            print(snapshot)
            if let currentName = snapshotValue["Name"]{
                self.currentUserName = currentName
                print(" this is current user name : \(self.currentUserName)=======================")
                
            }
            self.requestTableView.reloadData()
        }
        
    }
    

}
