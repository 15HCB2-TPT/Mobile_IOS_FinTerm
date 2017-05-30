//
//  BagMoney_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-Mac on 5/29/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class BagMoney_ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    
    @IBOutlet weak var view_danhsachcuatoi: UIView!
    @IBOutlet weak var view_themtuitien: UIView!
    @IBOutlet weak var view_thongtin: UIView!
    @IBOutlet weak var txt_nametui: UITextField!
    @IBOutlet weak var txt_loaitui: UITextField!
    @IBOutlet weak var txt_sotien: UITextField!
    @IBOutlet weak var scrollview: UIScrollView!
    var pickerView = UIPickerView()
    var pickOption = ["one", "two", "three", "seven", "fifteen"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        borderView(v: view_thongtin)
        borderView(v: view_danhsachcuatoi)
        borderView(v: view_themtuitien)
        
        txt_sotien.inputAccessoryView = addDoneButton()
        txt_loaitui.inputAccessoryView = addDoneButton()
        txt_nametui.inputAccessoryView = addDoneButton()
        
        pickerView.delegate = self
        txt_loaitui.inputView = pickerView
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(_ notification: Notification){
        let info = notification.userInfo
        let keyboard = (info?[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
        let contentinset = UIEdgeInsetsMake(0, 0, keyboard.height-44, 0)
        scrollview.contentInset = contentinset
        scrollview.scrollIndicatorInsets = contentinset
    }
    
    func keyboardWillHide(_ notification: Notification){
        let contentinset = UIEdgeInsetsMake(0, 0, 0, 0)
        scrollview.contentInset = contentinset
        scrollview.scrollIndicatorInsets = contentinset
    }
    
    //pickerview
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    //
    
    @IBAction func AddClick(_ sender: Any) {
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
