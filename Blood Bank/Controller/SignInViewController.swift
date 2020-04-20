//
//  SignInViewController.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 10/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import TextFieldEffects
import Firebase

class SignInViewController: UIViewController {
    @IBOutlet var txt_Email: HoshiTextField!
    @IBOutlet var txt_Password: HoshiTextField!
    @IBOutlet var btn_SignIn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        btn_SignIn.layer.cornerRadius = 20
        btn_SignIn.clipsToBounds = true

    }
    
    @IBAction func signIn_Btn(_ sender: Any) {
        Auth.auth().signIn(withEmail: txt_Email.text!, password: txt_Password.text!) { (auth, error) in
            if error != nil{
                print("error sign in")
            }else{
                print("SignIn successful")
                self.performSegue(withIdentifier: "goToMain", sender: self)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let vc = segue.destination as! UserInfoViewController
//        vc.user_Id = txt_Email.text!
    }

}
