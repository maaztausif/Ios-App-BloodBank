//
//  MainScreenViewController.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 18/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import ChameleonFramework

class MainScreenViewController: UIViewController {
    
    @IBOutlet var btn_UserInfo: UIButton!
    @IBOutlet var btn_BloodInfo: UIButton!
    @IBOutlet var btn_bloodRequest: UIButton!
    @IBOutlet var btn_donarRequest: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.flatCoffeeColorDark()
        btn_UserInfo.backgroundColor = UIColor.flatCoffee()
        btn_bloodRequest.backgroundColor = UIColor.flatCoffee()
        btn_donarRequest.backgroundColor = UIColor.flatCoffee()
        btn_BloodInfo.backgroundColor = UIColor.flatCoffee()
        

    }
    
    @IBAction func btn_call(_ sender: Any) {
  

        
    }
    
    }
    

