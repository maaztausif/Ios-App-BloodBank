//
//  MsgChatTableViewCell.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 08/05/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit

class MsgChatTableViewCell: UITableViewCell {
    
    @IBOutlet var lbl_name: UILabel!
    @IBOutlet var lbl_msg: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
