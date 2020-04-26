//
//  TableViewCell.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 21/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet var lbl_Name: UILabel!
    @IBOutlet var lbl_BloodType: UILabel!
    @IBOutlet var lbl_RequestFor: UILabel!
    @IBOutlet var lbl_Location: UILabel!
    @IBOutlet var txt_PhoneNo: UILabel!
    
    var phone_No = ""
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btn_Call(_ sender: Any) {
        if let url = NSURL(string: "tel://\(phone_No)"), UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.openURL(url as URL)
    }
    
  }
}