//
//  ViewController.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 08/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ViewController: UIViewController ,NVActivityIndicatorViewable {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func signUp(_ sender: Any) {
    }
    
    @IBAction func SignIn(_ sender: Any) {
        
    }

    func progressLoading(){
        let size = CGSize(width: 100, height: 100)
        startAnimating(size, message: "Loading...", type: NVActivityIndicatorType.pacman, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),  textColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), fadeInAnimation: nil)    }
}

