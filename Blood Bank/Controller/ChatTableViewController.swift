//
//  ChatTableViewController.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 06/05/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import Firebase

class ChatTableViewController: UITableViewController {
    
    var userNamesArray = [String]()
    var user_ID = ""
    var color : String!

    @IBOutlet var tableViewChat: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()
        self.color = UIColor.flatSand()?.hexValue()
        tableViewChat.register(UINib(nibName: "UserNameTableViewCell", bundle: nil), forCellReuseIdentifier: "userName")


    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(userNamesArray.count)=====================================")
        return userNamesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewChat.dequeueReusableCell(withIdentifier: "userName", for: indexPath) as! UserNameTableViewCell
        cell.userName.text = userNamesArray[indexPath.row]
        let colorName = UIColor(hexString: color )
        
        if let color = colorName?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(17)) {
            cell.backgroundColor = color
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    func retrieveData(){
        let database = Database.database().reference().child("All Users")
        
        database.observe(.childAdded) { (Snapshot) in
            print(Snapshot)
            let snapshotValue = Snapshot.value as! Dictionary<String,String>
            self.user_ID = snapshotValue["userID"]!
            let userNameDB = database.database.reference().child("user: \(self.user_ID)")
            userNameDB.observe(.childAdded, with: { (userSnapShot) in
                let userSnapshotValue = userSnapShot.value as! Dictionary<String,String>
                self.userNamesArray.append(userSnapshotValue["Name"]!)
                self.tableViewChat.reloadData()
                print(self.userNamesArray)

            })
            
            
            
            
        }

    }


}
