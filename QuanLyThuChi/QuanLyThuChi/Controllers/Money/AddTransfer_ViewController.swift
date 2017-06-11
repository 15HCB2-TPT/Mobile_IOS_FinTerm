//
//  AddTransfer_ViewController.swift
//  QuanLyThuChi
//
//  Created by Shin-MacDesk on 5/9/17.
//  Copyright © 2017 TPT.Group. All rights reserved.
//

import UIKit

class AddTransfer_ViewController: UIViewController, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var v: UIView!
    
    @IBOutlet weak var lblChuyenKhoan: UILabel!
    
    @IBOutlet weak var lblSoTien: UILabel!
    @IBOutlet weak var txt_sotien: UITextField!
    
    @IBOutlet weak var lblTuTaiKhoan: UILabel!
    @IBOutlet weak var txt_tutaikhoan: UITextField!
    
    @IBOutlet weak var lblDenTaiKhoan: UILabel!
    @IBOutlet weak var txt_dentaikhoan: UITextField!
    
    @IBOutlet weak var lblDienGiai: UILabel!
    @IBOutlet weak var txt_diengiai: UITextField!
    
    let datePicker = UIDatePicker()
    @IBOutlet weak var lblNgay: UILabel!
    @IBOutlet weak var txt_ngay: UITextField!
    
    @IBOutlet weak var btn_xong: UIButton!
    
    var ttk: BagMoney? = nil
    var dtk: BagMoney? = nil
    var tc: Type? = Database.select(entityName: "Type", predicater: NSPredicate(format: "name = 'Chi'"), sorter: nil)[0] as? Type
    var tt: Type? = Database.select(entityName: "Type", predicater: NSPredicate(format: "name = 'Thu'"), sorter: nil)[0] as? Type
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        borderView(v: v)
        lblChuyenKhoan.text = "Chuyển khoản"
        lblSoTien.text = "Số tiền"
        lblTuTaiKhoan.text = "Từ TK"
        lblDenTaiKhoan.text = "Đến TK"
        lblDienGiai.text = "Diễn giải"
        lblNgay.text = "Ngày"
        btn_xong.setTitle("Xong", for: .normal)
        
        txt_tutaikhoan.delegate = self
        txt_dentaikhoan.delegate = self
        txt_sotien.inputAccessoryView = addDoneButton()
        txt_diengiai.inputAccessoryView = addDoneButton()
        createDatePicker()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(_ notification: Notification){
        let info = notification.userInfo
        let keyboard = (info?[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
        let contentinset = UIEdgeInsetsMake(0, 0, keyboard.height - 44, 0)
        scrollview.contentInset = contentinset
        scrollview.scrollIndicatorInsets = contentinset
    }
    
    func keyboardWillHide(_ notification: Notification){
        let contentinset = UIEdgeInsetsMake(0, 0, 0, 0)
        scrollview.contentInset = contentinset
        scrollview.scrollIndicatorInsets = contentinset
    }
    
    func createDatePicker() {
        //datePicker la bien toan cuc
        //format date
        datePicker.datePickerMode = .dateAndTime
        
        //toolbar
        let toolbar=UIToolbar()
        toolbar.sizeToFit()
        
        //bar button item
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([flexBarButton,doneButton],animated:false)
        
        txt_ngay.text = "Hôm nay"
        txt_ngay.inputAccessoryView = toolbar
        txt_ngay.inputView = datePicker
    }
    
    func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        txt_ngay.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @IBAction func btndoneClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if(textField == txt_tutaikhoan) {
            pushData(storyboard: "Money", controller: "selectBagMoney", data: 21)
        }
        if(textField == txt_dentaikhoan) {
            pushData(storyboard: "Money", controller: "selectBagMoney", data: 22)
        }
        return false
    }
    
    override func uiPassedData(data: Any?, identity: Int) {
        if (identity == 21) {
            let tk = data as! BagMoney
            ttk = tk
            txt_tutaikhoan.text = ttk?.name
        }
        
        if (identity == 22) {
            let tk = data as! BagMoney
            dtk = tk
            txt_dentaikhoan.text = dtk?.name
        }
    }
    
//    @IBAction func btn_ghichep_TouchUpInside(_ sender: Any) {
//        pushData(storyboard: "Money", controller: "listRecord", data: nil)
//    }
    
    @IBAction func btn_xong_TouchUpInside(_ sender: Any) {
        if(ttk == nil || dtk == nil) {
            let alert = UIAlertController(title: "Lỗi", message: "Các tài khoản không được để trống.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            if(ttk == dtk) {
                let alert = UIAlertController(title: "Lỗi", message: "Không thể chuyển trong cùng tài khoản.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else {
                let mc: Money = Database.create()
                mc.money_type = tc
                mc.money = (txt_sotien.text?.doubleValue)!
                mc.money_category = nil
                mc.reason = txt_diengiai.text
                mc.money_bagmoney = ttk
                mc.date = datePicker.date as NSDate
                Database.save()
                
                let mt: Money = Database.create()
                mt.money_type = tt
                mt.money = (txt_sotien.text?.doubleValue)!
                mt.money_category = nil
                mt.reason = txt_diengiai.text
                mt.money_bagmoney = dtk
                mt.date = datePicker.date as NSDate
                mt.transfer = mc
                mc.transfer = mt
                Database.save()
            
                txt_sotien.text = ""
                txt_diengiai.text = ""
                createDatePicker()
            }
        }
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
