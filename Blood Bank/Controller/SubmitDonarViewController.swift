//
//  SubmitDonarViewController.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 22/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import TextFieldEffects
import Firebase

class SubmitDonarViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

    var currentTextField : Int!
    let pickerView = UIPickerView()
    
    @IBOutlet var txt_Name: HoshiTextField!
    @IBOutlet var txt_Gender: HoshiTextField!
    @IBOutlet var txt_BloodType: HoshiTextField!
    @IBOutlet var txt_LastBloodDonate: HoshiTextField!
    
    let bloodTypes = ["","A+","A-","O+","O-","B+","B-","AB+","AB-"]
    let gender = ["","Male","Female","Unspecified"]
    let last_Blood_Donate = ["","never","1 month","2 month","3 month","4 month","5 month","6 month","7 month","8 month","9 month","10 month","1 Year"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txt_Gender.delegate = self
        txt_BloodType.delegate = self
        txt_LastBloodDonate.delegate =  self

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickerView.delegate = self
        pickerView.dataSource = self
        currentTextField = textField.tag
        textField.inputView = pickerView
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == 1{
            return gender.count
        }else if currentTextField == 2{
            return bloodTypes.count
        }else{
            return last_Blood_Donate.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == 1{
            return gender[row]
        }else if currentTextField == 2{
            return bloodTypes[row]
        }else{
            return last_Blood_Donate[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == 1{
             txt_Gender.text = gender[row]
        }else if currentTextField == 2{
            txt_BloodType.text = bloodTypes[row]
        }else{
             txt_LastBloodDonate.text = last_Blood_Donate[row]
        }
    }

    @IBAction func submitDonation(_ sender: Any) {
        
        if txt_Name.text == "" || txt_Gender.text == "" || txt_BloodType.text == ""  || txt_LastBloodDonate.text == "" {
            
        }else{
            let donarDB = Database.database().reference().child("Donar List")
            let donarDic = ["Name":txt_Name.text!,"Gender":txt_Gender.text!,"Blood Type":txt_BloodType.text!,"Last Blood Donate":txt_LastBloodDonate.text!]
            
            donarDB.childByAutoId().setValue(donarDic) { (error, refrence) in
                if error != nil{
                    print("Error In Saving database======================================Donar database")
                }else{
                    print("Complete Saving database======================================Donar database")
                    
                }
            }
        }
        

    }
}
