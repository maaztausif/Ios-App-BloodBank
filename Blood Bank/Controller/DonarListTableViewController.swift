//
//  DonarListTableViewController.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 22/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import Firebase

class DonarListTableViewController: UITableViewController {
    
    @IBOutlet var donarTableView: UITableView!
    
    
    var donarListArray = [Donar]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        donarTableView.register(UINib(nibName: "DonarListTableViewCell", bundle: nil), forCellReuseIdentifier: "DonarCell")

        retrieveDonarLis()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0;//Choose your custom row height
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
         return donarListArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DonarCell", for: indexPath) as! DonarListTableViewCell
        cell.lbl_name.text = donarListArray[indexPath.row].name
        cell.lbl_BloodType.text = donarListArray[indexPath.row].blooadType
        cell.lbl_Gender.text = donarListArray[indexPath.row].gender
        cell.lbl_LastBloodDonate.text = donarListArray[indexPath.row].lastBloodDonate

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    func retrieveDonarLis(){
        let user_Donar = Donar()
        let donarDB = Database.database().reference().child("Donar List")
        donarDB.observe(.childAdded) { (Snapshot) in
            let snapshotValue = Snapshot.value as! Dictionary<String,String>
            user_Donar.name = snapshotValue["Name"]!
            user_Donar.gender = snapshotValue["Gender"]!
            user_Donar.blooadType = snapshotValue["Blood Type"]!
            user_Donar.lastBloodDonate = snapshotValue["Last Blood Donate"]!
            
            self.donarListArray.append(user_Donar)
            self.donarTableView.reloadData()
        }
    }
    

}
