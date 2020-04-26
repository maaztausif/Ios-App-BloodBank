//
//  DonarListTableViewCell.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 22/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit

class DonarListTableViewCell: UITableViewCell {

    @IBOutlet var lbl_name: UILabel!
    @IBOutlet var lbl_Gender: UILabel!
    @IBOutlet var lbl_BloodType: UILabel!
    @IBOutlet var lbl_LastBloodDonate: UILabel!
    @IBOutlet var txt_phoneNo: UILabel!
    
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
            UIApplication.shared.openURL(url as URL)    }
    }
}
