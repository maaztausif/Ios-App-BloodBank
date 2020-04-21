//
//  SubmitRequestViewController.swift
//  Blood Bank
//
//  Created by Maaz Bin Tausif on 20/04/2020.
//  Copyright © 2020 Maaz Bin Tausif. All rights reserved.
//

import UIKit
import TextFieldEffects
import Firebase

class SubmitRequestViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate{

    let pickerView = UIPickerView()
    var currentTextField: Int?
    var currentTextFieldName : UITextField!

    
    @IBOutlet var txt_Name: HoshiTextField!
    @IBOutlet var txt_BloodType: HoshiTextField!
    @IBOutlet var txt_RequestFor: HoshiTextField!
    @IBOutlet var txt_Location: HoshiTextField!
    @IBOutlet var txt_PhoneNo: HoshiTextField!
    
    let bloodTypes = ["","A+","A-","O+","O-","B+","B-","AB+","AB-"]
    let area = ["","F.B.Area","Malir","Qaidabad","Hedri","Nazimabad","ShahFaisal","Gulshan","Johar","Lyari","liaqtabad"]
    let request_For = ["Teacher","Son","Daughter","wife","Girl","Boy","Mother","Father","Collegue","Friends"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txt_BloodType.delegate = self
        txt_Location.delegate = self
        txt_RequestFor.delegate = self

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickerView.delegate = self
        pickerView.dataSource = self
        currentTextField = textField.tag
        currentTextFieldName = textField
        textField.inputView = pickerView
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == 2{
            return request_For.count
        }else if currentTextField == 3{
            return area.count
        }else if currentTextField == 1{
            return bloodTypes.count
        }
        else{
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == 1{
            return bloodTypes[row]
        }else if currentTextField == 2 {
            return request_For[row]
        }else if currentTextField == 3{
            return area[row]
        }else{
            return "yes"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == 1{
            txt_BloodType.text = bloodTypes[row]
        }else if currentTextField == 2 {
            txt_RequestFor.text = request_For[row]
        }else if currentTextField == 3{
            txt_Location.text = area[row]
        }
        else{
        }
    }
    
    
    @IBAction func btn_Save_Request(_ sender: Any) {
        
        if txt_Name.text == "" || txt_RequestFor.text == "" || txt_Location.text == "" || txt_PhoneNo.text == "" || txt_BloodType.text == "" {
            
            

        
        }else{
            
            let userID = Auth.auth().currentUser?.uid ?? "error"

            let userDB = Database.database().reference().child("Blood Request")
            
            let Request_Dic = ["Name":txt_Name.text! ,"Blood Type":txt_BloodType.text! ,"Request For":txt_RequestFor.text! ,"Area":txt_Location.text!,"Phone No":txt_PhoneNo.text!]
            
            
            userDB.childByAutoId().setValue(Request_Dic) { (error, refrence) in
                
                if error != nil{
                    print("saving database error=================================================")
                }else{
                    print("datbase saving complete in firebase====================================")
                }
                
            }
            
        }
    
    }
    
}
