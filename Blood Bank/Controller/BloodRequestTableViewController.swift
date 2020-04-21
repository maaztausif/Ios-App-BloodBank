//
//  BloodRequestTableViewController.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 20/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import Firebase

class BloodRequestTableViewController: UITableViewController {
    var request_Array = [Requests]()

    @IBOutlet var requestTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        cell.lbl_Name.text = request_Array[indexPath.row].name
        cell.lbl_BloodType.text = request_Array[indexPath.row].blood_Type
        cell.lbl_RequestFor.text = request_Array[indexPath.row].request_For
        cell.lbl_Location.text = request_Array[indexPath.row].location
        cell.txt_PhoneNo.text = request_Array[indexPath.row].phoneNo

        return cell
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
            
            self.request_Array.append(user_Requests)
            self.configureTableView()
            self.requestTableView.reloadData()
        }
    }
 


}
