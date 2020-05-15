//
//  ChatViewController.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 07/05/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    
    
    @IBOutlet var tableViewMsg: UITableView!
    @IBOutlet var txt_msg: UITextField!
    @IBOutlet var viewMsg: UIView!
    var chat_Mod = 2
    
    var currentUserName = ""
    var otherUserName = ""
    var userId = ""
    var otherUserId = ""
    var userDic = [String:String]()
    var check = ""
    
    var requestChat = false
    
    var donar_OtherUserID = ""
    
    var msgArray = [msg]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(check) for segue ==================Bhai segue to hua he")
        tableViewMsg.delegate = self
        tableViewMsg.dataSource = self
        retrieveMsg()
        
        print("user name = \(currentUserName)")
        print("other user name = \(otherUserName)")
        print("user id = \(userId)")
        print("other user id = \(otherUserId)")
        print("other chat mod = \(chat_Mod)")

        
       // tableViewChat.register(UINib(nibName: "UserNameTableViewCell", bundle: nil), forCellReuseIdentifier: "userName")

        tableViewMsg.register(UINib(nibName: "MsgChatTableViewCell",bundle: nil), forCellReuseIdentifier: "msgChat")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msgArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewMsg.dequeueReusableCell(withIdentifier: "msgChat", for: indexPath) as! MsgChatTableViewCell
        if msgArray[indexPath.row].sender == currentUserName{
            cell.lbl_msg.text = msgArray[indexPath.row].msg
            cell.lbl_name.text = msgArray[indexPath.row].sender
            cell.userImage.image = UIImage(named: "egg")
            cell.backgroundColor =  UIColor.flatSand()
            cell.msgView.backgroundColor = UIColor.flatCoffee()
            return cell
        }else{
            cell.lbl_msg.text = msgArray[indexPath.row].msg
            cell.lbl_name.text = msgArray[indexPath.row].sender
            cell.userImage.image = UIImage(named: "egg")
            cell.backgroundColor = UIColor.flatCoffee()
            cell.msgView.backgroundColor = UIColor.flatSand()

            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86.0
    }
    
    @IBAction func msgSend(_ sender: Any) {
        
        let msgDic = ["Sender":"\(currentUserName)","Message":"\(txt_msg.text!)"]
//                let database = Database.database().reference().child("chat").child("\(otherUserId)\(userId)")
//                database.childByAutoId().setValue(msgDic) { (error, refrence) in
//
//                    if error != nil{
//                        print("error in saving")
//                    }else{
//                        print("No error")
//                    }
//                }
        if chat_Mod == 1{
            
            print("\(chat_Mod)chat mod 1 he bhai ye =================")
            if otherUserId == ""{
                print("other userid khali he bhai")
                
                let db = Database.database().reference().child("Donar List")
                db.observe(.childAdded) { (snapshot) in
                    print("donar snapshot = \(snapshot)============================")
                    let snapshotValue = snapshot.value as! Dictionary<String,String>
                    
                    if self.otherUserName == snapshotValue["Name"]!{
                        self.donar_OtherUserID = snapshotValue["User ID"]!
                        print("jo ai he value donar list se id = \(self.donar_OtherUserID)")
                        
                        
                        //check
                        
                        
                        let database2 = Database.database().reference().child("chat").child("\(self.userId)\(self.donar_OtherUserID)")
                        database2.childByAutoId().setValue(msgDic) { (error, refrence) in
                            
                            if error != nil{
                                print("error in saving")
                            }else{
                                print("No error")
                            }
                        }
                    }
                    
                    
                }
                
                //            let database2 = Database.database().reference().child("chat").child("\(userId)\(donar_OtherUserID)")
                //            database2.childByAutoId().setValue(msgDic) { (error, refrence) in
                //
                //                if error != nil{
                //                    print("error in saving")
                //                }else{
                //                    print("No error")
                //                }
                //            }
                
            }else{
                let database2 = Database.database().reference().child("chat").child("\(userId)\(otherUserId)")
                database2.childByAutoId().setValue(msgDic) { (error, refrence) in
                    
                    if error != nil{
                        print("error in saving")
                    }else{
                        print("No error")
                    }
                }
                
            }
            
        }else if chat_Mod == 0{
            
            
            if otherUserId == ""{
                print("other userid khali he bhai")
                
                let db = Database.database().reference().child("Donar List")
                db.observe(.childAdded) { (snapshot) in
                    print("donar snapshot = \(snapshot)============================")
                    let snapshotValue = snapshot.value as! Dictionary<String,String>
                    
                    if self.otherUserName == snapshotValue["Name"]!{
                        self.donar_OtherUserID = snapshotValue["User ID"]!
                        print("jo ai he value donar list se id = \(self.donar_OtherUserID)")
                        
                        
                        //check
                        
                        
                        let database2 = Database.database().reference().child("chat").child("\(self.userId)\(self.donar_OtherUserID)")
                        database2.childByAutoId().setValue(msgDic) { (error, refrence) in
                            
                            if error != nil{
                                print("error in saving")
                            }else{
                                print("No error")
                            }
                        }
                    }
                    
                    
                }
                
                //            let database2 = Database.database().reference().child("chat").child("\(userId)\(donar_OtherUserID)")
                //            database2.childByAutoId().setValue(msgDic) { (error, refrence) in
                //
                //                if error != nil{
                //                    print("error in saving")
                //                }else{
                //                    print("No error")
                //                }
                //            }
                
            }else{
                let database2 = Database.database().reference().child("chat").child("\(userId)\(otherUserId)")
                database2.childByAutoId().setValue(msgDic) { (error, refrence) in
                    
                    if error != nil{
                        print("error in saving")
                    }else{
                        print("No error")
                    }
                }
                
            }
            
            
        }else{
            print("\(chat_Mod)chat mod else he ye he bhai ye =================")

            
            if otherUserId == ""{
                print("other userid khali he bhai")
                
                let db = Database.database().reference().child("Donar List")
                db.observe(.childAdded) { (snapshot) in
                    print("donar snapshot = \(snapshot)============================")
                    let snapshotValue = snapshot.value as! Dictionary<String,String>
                    
                    if self.otherUserName == snapshotValue["Name"]!{
                        self.donar_OtherUserID = snapshotValue["User ID"]!
                        print("jo ai he value donar list se id = \(self.donar_OtherUserID)")
                        
                        
                        //check
                        
                        
                        let database2 = Database.database().reference().child("chat").child("\(self.userId)\(self.donar_OtherUserID)")
                        database2.childByAutoId().setValue(msgDic) { (error, refrence) in
                            
                            if error != nil{
                                print("error in saving")
                            }else{
                                print("No error")
                            }
                        }
                    }
                    
                    
                }
                
                //            let database2 = Database.database().reference().child("chat").child("\(userId)\(donar_OtherUserID)")
                //            database2.childByAutoId().setValue(msgDic) { (error, refrence) in
                //
                //                if error != nil{
                //                    print("error in saving")
                //                }else{
                //                    print("No error")
                //                }
                //            }
                
            }else{
                let database2 = Database.database().reference().child("chat").child("\(userId)\(otherUserId)")
                database2.childByAutoId().setValue(msgDic) { (error, refrence) in
                    
                    if error != nil{
                        print("error in saving")
                    }else{
                        print("No error")
                    }
                }
                
            }
            
        }

        

        txt_msg.text = ""
    }
    
    func retrieveMsg() {
        
        let database = Database.database().reference().child("chat").child("\(userId)\(otherUserId)")
        database.observe(.childAdded) { (snapshot) in
            print("\(snapshot)============================3453")
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let msgs = msg()
            msgs.msg = snapshotValue["Message"]!
            msgs.sender = snapshotValue["Sender"]!
            self.msgArray.append(msgs)
            self.tableViewMsg.reloadData()
        }
        self.tableViewMsg.reloadData()

    }
    

}
