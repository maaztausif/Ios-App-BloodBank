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
    
    var userIdArray = [String]()

    @IBOutlet var tableViewChat: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveData()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    func retrieveData(){
        let database = Database.database().reference().child("All Users")
        
        database.observe(.childAdded) { (Snapshot) in
            print(Snapshot)
            let snapshotValue = Snapshot.value as! Dictionary<String,String>
            self.userIdArray.append(snapshotValue["userID"]!)
        }
    }


}
