//
//  SignUpViewController.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 10/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import TextFieldEffects
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet var txt_Email: HoshiTextField!
    
    @IBOutlet var txt_Password: HoshiTextField!
    
    @IBOutlet var btn_signUp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btn_signUp.layer.cornerRadius = 20
        btn_signUp.clipsToBounds = true
    }
    
    @IBAction func signUp_btn(_ sender: Any) {
        Auth.auth().createUser(withEmail: txt_Email.text!, password: txt_Password.text!) { (user, error) in
            if error != nil{
                print("error creating user======================================")
            }else{
                print("creature suer Succesful==================================")
                self.performSegue(withIdentifier: "goToInfo", sender: self)

            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! InfoViewController
        vc.user_Id = txt_Email.text! 
    }
    
}
